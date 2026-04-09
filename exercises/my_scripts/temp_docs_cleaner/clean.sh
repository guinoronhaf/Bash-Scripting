#!/bin/bash

FILES="./temp_docs/*.pdf"

for file in $FILES; do
	stats=$(stat -c  %x "$file")
	echo "$stats"
done
