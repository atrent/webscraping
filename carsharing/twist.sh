#! /bin/bash
# WTFPL Licence (http://www.wtfpl.net/)
# Author: Pierlauro Sciarelli
wget http://twistcar.it/start_twist.js -O /tmp/twists
for car in $(grep ^point /tmp/twists)
do
	if(grep ^google.maps.LatLng <<< $car >/dev/null); then
		sed 's/\(.*\)(\|)\(.*\)//g' <<< $car
	fi
done
