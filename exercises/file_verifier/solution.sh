#!/bin/bash

path=$1

if [ -f $path ]; then
	echo "Se trata de um arquivo."
elif [ -d $path ]; then
	echo "Se trata de um diretório."
else
	echo "Path inválido no sistema."
fi
