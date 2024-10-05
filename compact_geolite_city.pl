#!/usr/bin/perl -w

# Compact GeoLite City CSV CIDR-ranges

use strict;
use NetAddr::IP;

my %c;

my $header = <STDIN>;
die unless $header =~ /^network,/;
while (<STDIN>) {
    chomp;
    next if $_ =~ m!^1\.1\.1\.1/32,6255151,!;
    next unless $_ =~ m!^[0-9a-f:.\/]+,\d+,!;
    my @cols = split(/,/, $_, -1);
    push @{$c{"$cols[1],,,,,$cols[6],$cols[7],$cols[8],"}}, $cols[0];
}

my %result;
foreach my $cc (keys %c) {
    my @cidrs;
    foreach my $cidr (@{$c{$cc}}) {
        push @cidrs, NetAddr::IP->new($cidr);
    }
    @cidrs = NetAddr::IP::Compact(@cidrs);
    foreach my $cidr (@cidrs) {
        my $ip = $cidr;
        $ip =~ s!/(.+)!!;
        my $suffix = $1;
        if (index($ip, ':') != -1) {
            my $n = NetAddr::IP::Util::ipv6_aton($ip);
            $cidr = NetAddr::IP::Util::ipv6_ntoa($n)."/$suffix";
            $result{$n} = "$cidr,$cc";
        } else {
            $result{NetAddr::IP::inet_aton($ip)} = "$cidr,$cc";
        }
    }
}

print $header;
foreach (sort keys %result) {
    print $result{$_}."\n";
}
