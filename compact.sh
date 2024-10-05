#!/bin/bash

# Create modified versions of GeoLite2 zips, which have
# - CIDR-ranges compacted
# - IPv4-mapped IPv6 addresses added

# Create GeoLite2-Country-CSV_mod.zip from GeoLite2-Country-CSV.zip
if [ -f GeoLite2-Country-CSV.zip ]; then
  rm -rf temp$$
  mkdir temp$$
  unzip -q -d temp$$ GeoLite2-Country-CSV.zip
  B4=$(find temp$$ -name '*-Country-Blocks-IPv4.csv')
  B6=$(find temp$$ -name '*-Country-Blocks-IPv6.csv')
  # Compact CIDRs
  ./compact_geolite_country.pl <$B4 >$B4.tmp && mv -f $B4.tmp $B4
  ./compact_geolite_country.pl <$B6 >$B6.tmp && mv -f $B6.tmp $B6
  # Add IPv4-mapped IPv6 addresses (Country version)
  tail -n+2 $B4 | awk -F, '{ split($1,a,"/"); split(a[1],a1,"."); m = 96+a[2]; printf("::ffff:%02x%02x:%02x%02x/%d,%s,%s,%s,%s,%s\n"),a1[1],a1[2],a1[3],a1[4],m,$2,$3,$4,$5,$6}' >>$B6
  rm -f GeoLite2-Country-CSV_mod.zip
  (cd temp$$; zip -q -1 -r ../GeoLite2-Country-CSV_mod.zip *)
  rm -rf temp$$
fi

# Create GeoLite2-City-CSV_mod.zip from GeoLite2-City-CSV.zip
if [ -f GeoLite2-City-CSV.zip ]; then
  rm -rf temp$$
  mkdir temp$$
  unzip -q -d temp$$ GeoLite2-City-CSV.zip
  B4=$(find temp$$ -name '*-City-Blocks-IPv4.csv')
  B6=$(find temp$$ -name '*-City-Blocks-IPv6.csv')
  # Compact CIDRs
  ./compact_geolite_city.pl <$B4 >$B4.tmp && mv -f $B4.tmp $B4
  ./compact_geolite_city.pl <$B6 >$B6.tmp && mv -f $B6.tmp $B6
  # Add IPv4-mapped IPv6 addresses (City version)
  tail -n+2 $B4 | awk -F, '{ split($1,a,"/"); split(a[1],a1,"."); m = 96+a[2]; printf("::ffff:%02x%02x:%02x%02x/%d,%s,%s,%s,%s,%s,%s,%s,%s,%s\n"),a1[1],a1[2],a1[3],a1[4],m,$2,$3,$4,$5,$6,$7,$8,$9,$10}' >>$B6
  rm -f GeoLite2-City-CSV_mod.zip
  (cd temp$$; zip -q -1 -r ../GeoLite2-City-CSV_mod.zip *)
  rm -rf temp$$
fi

# Create GeoLite2-ASN-CSV_mod.zip from GeoLite2-ASN-CSV.zip
if [ -f GeoLite2-ASN-CSV.zip ]; then
  rm -rf temp$$
  mkdir temp$$
  unzip -q -d temp$$ GeoLite2-ASN-CSV.zip
  B4=$(find temp$$ -name '*-ASN-Blocks-IPv4.csv')
  B6=$(find temp$$ -name '*-ASN-Blocks-IPv6.csv')
  # (CIDR compacting not needed)
  # Add IPv4-mapped IPv6 addresses (ASN version)
  tail -n+2 $B4 | awk -F, '{ split($1,a,"/"); split(a[1],a1,"."); m = 96+a[2]; printf("::ffff:%02x%02x:%02x%02x/%d,%s,%s\n"),a1[1],a1[2],a1[3],a1[4],m,$2,$3}' >>$B6
  rm -f GeoLite2-ASN-CSV_mod.zip
  (cd temp$$; zip -q -1 -r ../GeoLite2-ASN-CSV_mod.zip *)
  rm -rf temp$$
fi

