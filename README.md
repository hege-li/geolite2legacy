# geolite2legacy (forked with extra features)

This tool will convert MaxMind GeoLite2 Database to the old legacy format.

It's based on [mmutils](https://github.com/mteodoro/mmutils.git) but it reads new GeoLite2
directly from zip files containings CSV databases.

You can download databases from
[https://dev.maxmind.com/geoip/geoip2/geolite2/](https://dev.maxmind.com/geoip/geoip2/geolite2/)

It's tested with python/pypy 3.6+

## Limitations

- Processing may be slow, expecially for City blocks, consider using pypy, it is a lot faster
- Some software may expect iso-8859-1 encoded names, but the script will output utf-8 by default.
  You should use `-e latin-1` for iso-8859-1 output, which will be converted with [https://pypi.org/project/Unidecode/](Unidecode) module.

## Examples to create all possible database versions

```text
# Country/City
./compact.sh
./geolite2legacy.py -i GeoLite2-Country-CSV_mod.zip -f geoname2fips.csv -e latin-1 -o GeoIP.dat
./geolite2legacy.py -i GeoLite2-Country-CSV_mod.zip -f geoname2fips.csv -6 -e latin-1 -o GeoIPv6.dat
./geolite2legacy.py -i GeoLite2-City-CSV_mod.zip -f geoname2fips.csv -e latin-1 -o GeoIPCity.dat
./geolite2legacy.py -i GeoLite2-City-CSV_mod.zip -f geoname2fips.csv -6 -e latin-1 -o GeoIPCityv6.dat
# ASN
./geolite2legacy.py -i GeoLite2-ASN-CSV.zip -e latin-1 -o GeoIPASNum.dat
./geolite2legacy.py -i GeoLite2-ASN-CSV.zip -6 -e latin-1 -o GeoIPASNumv6.dat
# ORG
./geolite2legacy.py -i GeoLite2-ASN-CSV.zip --org -e latin-1 -o GeoIPOrg.dat
./geolite2legacy.py -i GeoLite2-ASN-CSV.zip --org -6 -e latin-1 -o GeoIPOrgv6.dat
# ISP
./geolite2legacy.py -i GeoLite2-ASN-CSV.zip --isp -e latin-1 -o GeoIPISP.dat
./geolite2legacy.py -i GeoLite2-ASN-CSV.zip --isp -6 -e latin-1 -o GeoIPISPv6.dat
```

## Usage

```text
usage: geolite2legacy.py [-h] -i INPUT_FILE -o OUTPUT_FILE [-f FIPS_FILE]
                         [-e ENCODING] [-d] [-6] [--org] [--isp]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file INPUT_FILE
                        input zip file containings csv databases
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        output GeoIP dat file
  -f FIPS_FILE, --fips-file FIPS_FILE
                        geonameid to fips code mappings
  -e ENCODING, --encoding ENCODING
                        encoding to use for the output rather than utf-8
  -d, --debug           debug mode
  -6, --ipv6            use ipv6 database
  --org                 create org-db from asn
  --isp                 create isp-db from asn
```

```text
The MIT License (MIT)

Copyright (c) 2015 Mark Teodoro
Copyright (c) 2019 Gianluigi Tiesi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
