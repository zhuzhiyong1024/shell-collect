#!/bin/bash

base_dir="."
condition="backend"
file_to_bak_del_array=( $(find $base_dir -type f | grep $condition) )

if [[ -z $file_to_bak_del_array ]]; then
	echo "No files to delete."
	exit -1
fi

backup_dir="$HOME/backup-`date +%Y%m%d`"
if [ ! -d $backup_dir ]; then
	mkdir $backup_dir || { echo "Failed to create backup dir: $backup_dir";  exit 2; }
fi

for file_to_bak_del in "${file_to_bak_del_array[@]}"
do
	echo "backup and delete $file_to_bak_del"
	cp $file_to_bak_del $backup_dir && rm $file_to_bak_del
done
