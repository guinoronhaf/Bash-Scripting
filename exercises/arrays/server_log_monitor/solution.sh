#!/bin/bash

# Criar um array indexado com logs simulados: logs=("srv01:erro" "srv02:ok" "srv01:erro" "srv03:erro" "srv02:erro" "srv01:ok").
#
# Criar um array associativo chamado contagem_erros.
#
# Percorrer o array de logs.
#
# Para cada item, usar o comando cut ou expansão de string para separar o nome do servidor e o status.
#
# Se o status for "erro", incrementar o valor no array associativo usando o nome do servidor como chave.
#
# Ao final, exibir um relatório: Servidor srv01 teve X erros.

declare -A logs_err_count

logs=(
	"srv01:erro"
	"srv02:ok"
	"srv01:erro"
	"srv03:erro"
	"srv02:erro"
	"srv01:ok"
)

for log in "${logs[@]}"; do
	server_name=${log%:*}
	status=${log#*:} # no parameter expression, não precisa tratar o log como variável ($)
	if [[ $status == "erro" ]]; then # para igualdade com ==, deve-se usar [[
		if [[ -v logs_err_count[$server_name] ]]; then
			current_value=${logs_err_count[$server_name]}
			logs_err_count[$server_name]=$(( current_value+1 ))
		else
			logs_err_count[$server_name]=1
		fi
	fi
done

echo "=== RELATÓRIO ==="

for key in "${!logs_err_count[@]}"; do
	k_errors=${logs_err_count[$key]}
	echo "Servidor $key teve $k_errors erro(s)."
done
