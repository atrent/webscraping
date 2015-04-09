#!/bin/bash


#estraggo lista per cap
CAP=20122
URL=http://www.justeat.it/area/$CAP

wget $URL

#nomi
grep restaurantLogo $CAP |cut -f2 -d'"'|cut -f2 -d-|cut -f1 -d/

#tipo cucina... troppo complicato
#grep restaurantCuisines $CAP
