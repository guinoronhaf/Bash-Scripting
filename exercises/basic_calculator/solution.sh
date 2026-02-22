#!/bin/bash

value1=$1
value2=$2
op=$3

if [[ "$op" == "+" ]]; then
	echo $(( $value1 + $value2 ))
elif [[ "$op" == "-" ]]; then
	echo $(( $value1 - $value2 ))
elif [[ "$op" == "." ]]; then
	echo $(( $value1 * $value2 ))
elif [[ "$op" == "/" ]]; then
	echo $(( $value1 / $value2 ))
else
	echo "Ivalid operation!"
	exit 1
fi
