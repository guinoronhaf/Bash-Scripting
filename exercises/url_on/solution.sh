#!/bin/bash

url=$1

# essa condicional faz sentido porque todo comando, ao ser executado, retorna um código de saída, sendo 0 pra sucesso e {1.255} para algum erro
if ping -c 1 $url &> /dev/null # &> /dev/null serve pra esconder a saída do comando
then
	echo "site no ar"
else
	echo "alguma coisa errada"
fi
