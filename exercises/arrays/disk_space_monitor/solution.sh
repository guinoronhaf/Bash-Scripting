#!/bin/bash

# Criar um array indexado chamado particoes contendo os caminhos: /, /home, e /tmp.
#
# Usar um loop for para percorrer o array.
#
# Para cada partição, usar o comando df -h [particao] para pegar a porcentagem de uso.
#
# Extra: Se o uso for maior que 80%, imprimir uma mensagem de "ALERTA" em vermelho; caso contrário, imprimir "OK" em verde.

RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

particoes=(/ /home /tmp)

for part in "${particoes[@]}"; do
	percent_part=$(df $part --output=pcent | tail -1)
	percent_part_value=${percent_part%\%*} # caractere literal %
	if [ $percent_part_value -gt 80 ]; then
		echo -e "${RED}passou!${NCOLOR}" # deve-se usar a flag -e, para de caracteres de escape (como o ansi - cores) sejam interpretados
	else
		echo -e "${GREEN}de boa!${NCOLOR}"
	fi
	# echo $percent_part
	# echo $percent_part_value
	# echo $part
done

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
