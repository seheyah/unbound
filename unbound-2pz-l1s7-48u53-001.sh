#!/bin/ksh
####### unbound-2pz-l1s7-48u53-001.sh
### AUTHOR:	seheyah
### CREATION:	2023/02/22

### DATE: 20//
### UPDATE:
#

### CONSTANT
# ARRAY

# FILE
filebkp01="your_backup_path/2pz-l1s7-48u53-001.bkp"
filerun01="/var/unbound/etc/2pz-l1s7-48u53-001.txt"
filerun02="/var/unbound/etc/unbound.conf"
filetmp01="/j05hu4/tmp/0.txt"
filetmp02="/j05hu4/tmp/1.txt"
filetmp03="/j05hu4/tmp/2.txt"
filetmp04="/j05hu4/tmp/3.txt"

# STRING
str0x00="unbound-2pz-l1s7-48u53-001.sh"
str0x01="2pz-l1s7-48u53-001.txt"
str0x02="2023/02/22"
str0x03="Falken"
str0x04="0xff"
str0x05="https://urlhaus.abuse.ch/downloads/rpz"

### VARIABLE
# INTEGER

##### MAIN
echo "|-------------------------------------------------------------------------------------------"
echo "| 0-0-0- |-> $str0x00\n|\n|\t Service: UNBOUND\n|\t Action: Update file $str0x01\n|"
echo "|\t Version: $str0x04\n|\t Release date: $str0x03\n|\t Release name: $str0x02"
echo "|-------------------------------------------------------------------------------------------"

### MAIN

## > Download file
ftp -o $filetmp01 $str0x05 > /dev/null

## > Test file and exit the generation of the file
if [ ! -f $filetmp01 ]; then
	echo "|\n| 0-0-0- |-> File download: error\n|"
	echo "|-------------------------------------------------------------------------------------------"
	echo "| exit 0"
	echo "|-------------------------------------------------------------------------------------------"
	exit 0
else
	echo "|\n| 0-0-0- |-> File download: done"

	sed -i '$d' $filetmp01
	sed -i '1,3d' $filetmp01
	sed -i '/^;/d' $filetmp01
	cat $filetmp01 | awk '{ print $1 }' | sort -du > $filetmp02
	
	while read line; do
		echo "$line CNAME ." >> $filetmp03
	done < $filetmp02

	cat $filecfg01 $filetmp03 > $filetmp04
	echo "" >> $filetmp04

	a="$(cat $filerun01 | grep "CNAME" | wc -l)"
	b="$(cat $filetmp04 | grep "CNAME" | wc -l)"

	echo "|\n|\t Total of previous entries:\t$a"
	echo "|\t Total of new entries:\t\t$b"

fi

## > Make a backup file of the previous version
mv $filerun01 $filebkp01
mv $filetmp04 $filerun01

## > Check UNBOUND daemon with the new file
unbound-checkconf /var/unbound/etc/unbound.conf > /dev/null 2>&1
ERROR_CODE=$?

if [ $ERROR_CODE != 0 ]; then
	echo "|\n| 0-0-0- |-> UNBOUND can NOT be reload with the new file"
	mv $filebkp01 $filerun01
        rcctl reload unbound > /dev/null
        echo "| 0-0-0- |-> UNBOUND reloaded with the previous file\n|"
else
	echo "|\n| 0-0-0- |-> UNBOUND can be reload with the new file"
       	rcctl reload unbound > /dev/null
        echo "| 0-0-0- |-> UNBOUND reloaded with the new file\n|"
fi

rm -f $filetmp01
rm -f $filetmp02
rm -f $filetmp03

echo "|-------------------------------------------------------------------------------------------"
echo "|\n| 0-0-0- |-> Clean workspace: done\n|"
echo "|-------------------------------------------------------------------------------------------"
echo "| exit 0"
echo "|-------------------------------------------------------------------------------------------"
exit 0

####### END
