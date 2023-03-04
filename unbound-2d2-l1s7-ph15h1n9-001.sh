#!/bin/ksh
####### unbound-2d2-l1s7-ph15h1n9-001.sh
### AUTHOR:	seheyah
### CREATION:	2022/08/21

### DATE: 20//
### UPDATE:
#

### CONSTANT
# ARRAY

# FILE
filebkp01="your_backup_path/2d2-l1s7-ph15h1n9-001.bkp"
filerun01="/var/unbound/etc/2d2-l1s7-ph15h1n9-001.txt"
filerun02="/var/unbound/etc/unbound.conf"
filetmp01="/tmp/0.txt"
filetmp02="/tmp/1.txt"
filetmp03="/tmp/2.txt"

# STRING
str0x00="unbound-53cu217y-ph15h1n9"
str0x01="2d2-l1s7-ph15h1n9-001.txt"
str0x02="2022/08/21"
str0x03="Falken"
str0x04="0xff"
str0x05="https://dl.red.flag.domains/red.flag.domains.txt"
str0x06="$(date +"%Y%m%d%H%M%S")"

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
	
	sed -i '1,2d' $filetmp01
	cat $filetmp01 | awk '{ print $1 }' > $filetmp02

	while read line; do
		echo "\tlocal-zone: \"$line\" redirect" >> $filetmp03
		echo "\tlocal-data: \"$line 3600 IN A 0.0.0.0\"" >> $filetmp03
	done < $filetmp02

	echo "" >> $filetmp03

	a="$(cat $filerun01 | grep "local-zone" | wc -l)"
	b="$(cat $filetmp03 | grep "local-zone" | wc -l)"

	echo "|\n|\t Total of previous entries:\t$a"
	echo "|\t Total of new entries:\t\t$b"
fi

## > Make a backup file of the previous version
mv $filerun01 $filebkp01
mv $filetmp03 $filerun01

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

echo "|-------------------------------------------------------------------------------------------"
echo "|\n| 0-0-0- |-> Clean workspace: done\n|"
echo "|-------------------------------------------------------------------------------------------"
echo "| exit 0"
echo "|-------------------------------------------------------------------------------------------"
exit 0

####### END
