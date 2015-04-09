#!/bin/bash

FILE=$1
AREA=$2
#echo Param $*

if
 ! test -f $FILE
then
 exit
fi

#NOME=$(grep -v html $FILE|sed 's/<br>/ /g'|vilistextum -a - -|grep 'monitorati'|tr -s " "|cut -f4- -d" "|awk '{print $3"-"$2"-"$1}')
NOME=$(grep -v html $FILE|sed 's/<br>/ /g'|vilistextum -a - -|grep 'monitorati'|tr -s " "|awk '{print $7"-"$6"-"$5}')
#echo Nome $NOME

if
 test ${#NOME} -lt 1
then
 exit
fi

if
 test ${#AREA} -ge 1
then
 NOME=${NOME}_$AREA
fi


if
 test -f $GENERATED/$NOME.dati
then
 #file esiste
 exit
fi

echo Dati del $NOME

# cambiare tutto!!!
# html2text?
# e poi http://stackoverflow.com/questions/19177721/extract-lines-between-two-patterns-from-a-lfile
# o http://stackoverflow.com/questions/9315513/read-lines-between-two-keywords
# o http://stackoverflow.com/questions/15196750/sed-extract-text-between-two-patterns-where-second-pattern-may-be-either-of-one


# HEADER
#data=$(basename $GENERATED/$NOME.dati .dati|tr "-" "/")
#echo -n "Data;" > $GENERATED/$NOME.dati
echo -n Stazione > $GENERATED/$NOME.dati
html2text -width 1000 $FILE|uni2ascii -qB| awk '/I valori/{f=1;next}/Rilevament/{f=0}f'|sed '/0x/d'|tr -s ' ' ';'|tr -d '\n' >> $GENERATED/$NOME.dati
echo  >> $GENERATED/$NOME.dati

# DATI
#html2text $FILE| awk '/Unit/,/PM10/ {print}' 
#html2text $FILE| awk '/misura/{p=1;next};p;/PM10/{p=0}'
#html2text $FILE|sed -nE '/misura/,/PM10/p'
#echo -n "$data;" >> $GENERATED/$NOME.dati
html2text -width 1000 $FILE|uni2ascii -qB| awk '/Unit/{f=1;next}/PM10/{f=0}f'|sed '/0x/d'|sed 's/Stud/Stud /'|sed 's/CittA _/Citta_/'|tr -s ' ' ';' |tr -s '_' ' '>> $GENERATED/$NOME.dati
#html2text -width 1000 $FILE|uni2ascii -qB >> $GENERATED/$NOME.dati.RAW

 if
	test $(stat -c %s $GENERATED/$NOME.dati) -lt 100
 then
	echo In $0, file $GENERATED/$NOME.dati troppo piccolo, qualcosa va storto...
	#ls -l $FILE
 fi
