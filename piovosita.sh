#!/bin/bash

echo $0 "ROTTO!!!"
exit

MESI=$(cut -f 2 -d/ mesi.sed)
ANNI=$(cut -f 1 -d/ CSV/allInOne-num-sorted.csv |sort|uniq|grep -v Data)

for mese in $MESI
do
 for anno in $ANNI
 do
  wget -U "firefox" -O CSV/piovositaMilano-$anno-$mese.csv "http://www.ilmeteo.it/portale/archivio-meteo/Milano/$anno/$mese?format=csv"
 done
done

cd CSV

cat piovositaMilano-*csv |tr -d '"'|sort|uniq> PioggiaMilano.csv

