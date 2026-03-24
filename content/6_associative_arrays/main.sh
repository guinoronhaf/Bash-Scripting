#!/bin/bash

declare -A arr
# echo $? # apenas para testar se essa sintaxe para a criação de arrays associativos é reconhecida

arr[foo]=1
arr[bar]=2
arr[baz]=3

# echo "${arr}"
# echo "${arr[foo]}"
# echo "${arr[@]}"

# echo "${!arr[*]}"

for key in "${!arr[@]}"; do
	value=${arr[$key]}
	echo "Pair: $key=$value"
done
