#!/bin/bash

###########################################################################
# segnalatore - shell scripts to log some gps data and user markers
# Copyright (C) 2009 Andrea Trentini (ego AT atrent DOT it)

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
###########################################################################

#@ converte un indirizzo in una location (contatta Yahoo)

##@ converte un indirizzo in una location (contatta google via tor)

#echo GeoCoding...

# YAHOO
#wget -U "Mozilla" -nv -O tmp.html 'http://api.maps.yahoo.com/ajax/geocode?appid=onestep&qt=1&id=m&qs='"$*"
#COORD=$(cat tmp.html|cut -f5,6 -d":")
#LAT=$(echo $COORD|cut -f1 -d,)
#LONG=$(echo $COORD|cut -f2 -d,|cut -f2 -d:|cut -f1 -d"}")
#echo ==================
#echo coord: $COORD
# vecchia versione
#echo lat=$LAT,long=$LONG
#echo $LAT $LONG
#rm tmp.html
#exit

# GOOGLE ROTTO!

#export HTTP_PROXY=localhost:8118
#export http_proxy=$HTTP_PROXY

wget -U "Mozilla" -nv -O tmp.html 'http://maps.google.it/maps?f=q&source=s_q&hl=it&q='"$*"

COORD=$(cat tmp.html|tr '{' '\n' |tr '}' '\n'|tr -s " " "\n"|grep lat|grep lng|grep ,|grep -vi pixel|grep -vi latlng|grep -vi tiles|sort |uniq -c|tail -1 |tr -s " " |cut -f3 -d" ")
LAT=$(echo $COORD|cut -f1 -d,|cut -f 2 -d:)
LONG=$(echo $COORD|cut -f2 -d,|cut -f 2 -d:)

#echo ==================
#echo coord: $COORD
echo lat=$LAT,long=$LONG




