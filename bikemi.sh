#!/bin/bash

#######################################################################
# BIKEMI parser - version 0.72 (enough for my purposes)
# Copyright (C) 2008  Andrea Trentini (www.atrent.it)
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, browse http://www.gnu.org/licenses/gpl.txt
#######################################################################

# TODO: comincia a diventare lento... ;)
#set -x

function headers()
{
 echo "''STAZIONE : NR.BICI (se =0 non ce ne sono) : NR.STALLI DISPONIBILI (se =0 non si possono restituire bici, e' piena la stazione)''"
}

function mycat()
{
 head -1 $1
 tail -n +2 $1 | while
 read riga
 do
  echo '*' $riga |sed "s/:/\t:\t/g"
 done
}

function pagina()
{
echo '= BikeMI by atrent ='
date

echo '== Vuote (non ci sono bici) =='
echo
mycat vuote.txt
echo

echo '== Piene (non si possono restituire bici) =='
echo
mycat piene.txt
echo

echo '= Stato complessivo ='
echo
mycat ultima.txt
}

############# MAIN ###############

#workaround per crontab
cd $(dirname $0)

DATA=data

FILENAME=$DATA/$(date +%y%m%d%H%M).txt

rm local*php local*php.? mappa*aspx 2>/dev/null
wget -q http://www.bikemi.com/it/mappa-stazioni.aspx
touch mappa.aspx

headers >$FILENAME

# qui si potrebbe usare xml2?
# NO, problemi di encoding... lasciamo stare

grep Artem.Google.MarkersBehavior mappa-stazioni.aspx | cut -f2- -d, |rev|cut -f4- -d,  |rev |json_pp |grep info|cut -f2- -d: |cut -c82-|sed "s/<\/span><br\/><ul><li>Biciclette disponibili: /:/g"|sed "s/<\/li><li>Stalli disponibili: /:/g"|sed "s/<\/li><\/ul><\/div>\"//g"|tr -d "," >>$FILENAME

rm ultima.txt
#inserire fdupes?
ln -s $FILENAME ultima.txt

# vuote o piene
headers >allarmi.txt
grep ':0' ultima.txt >> allarmi.txt

headers >vuote.txt
grep ':0:' ultima.txt >> vuote.txt

headers >piene.txt
grep ':0$' ultima.txt >> piene.txt

### begin HTML
pagina > ultima.wiki
parsewiki ultima.wiki >ultima.html
### end HTML

#prima di fare le stat elimino i file "vuoti"
find data -size -200c|xargs rm 2>/dev/null

gzip -9 $FILENAME
