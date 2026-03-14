#!/bin/bash

extension=".txt"

for file in *$extension
do
	file_name=${file%.*}
	new_name="backup_$file_name.txt"
	mv $file $new_name
done
