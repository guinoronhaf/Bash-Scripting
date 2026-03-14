#!/bin/bash

path=$1

if [ -f $path ]; then
	echo "Se trata de um arquivo."
	test -w $path && echo "você pode escrever nesse arquivo" || echo "você não pode escrever nesse arquivo"
	# as condições simples também podem ser verificadas usando "test", em que && testa o caso positivo e ||, o negativo
elif [ -d $path ]; then
	echo "Se trata de um diretório."
	test -w $path && echo "você pode escrever nesse diretório" || echo "você não pode escrever nesse diretório"
else
	echo "Path inválido no sistema."
fi
