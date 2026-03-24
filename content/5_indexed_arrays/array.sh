#!/bin/bash

# first_array=(foo bar baz)
# second_array=( "${first_array[@]}" )
# second_array+=(outro elemento)
#
# for item in "${second_array[@]}"; do
# 	echo $item
# done

array=(foo bars baz)
echo "${#array[1]}"
