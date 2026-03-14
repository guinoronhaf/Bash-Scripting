#!/bin/bash

number=$1

echo "Tabuada de $number:"

for i in {1..10}
do
	val=$(( $number * $i ))
	echo "$number x $i = $val"
done
