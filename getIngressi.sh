#!/bin/bash

if
 ! cd $(dirname $0)
then
 exit 1
fi

find -name '20*' -size -100c -exec rm {} \;


for ANNO in $(seq 2012 2014)
do
 for MESE in $(seq -w 01 12)
 do
  if
   ! test -e $ANNO-$MESE.mese
  then
   wget -O $ANNO-$MESE.mese http://areac.amat-mi.it/areac/json/accessiGiornalieri/$ANNO-$MESE-01
  fi
  for GIORNO in $(seq -w 01 31)
  do
   if
    ! test -e $ANNO-$MESE-$GIORNO.giorno
   then
    wget -O $ANNO-$MESE-$GIORNO.giorno http://areac.amat-mi.it/areac/json/accessiOrari/$ANNO-$MESE-$GIORNO
   fi
  done
 done
done
