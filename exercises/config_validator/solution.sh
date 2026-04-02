#!/bin/bash

# Cenário: Você tem um arquivo de configuração .env ou um arquivo de texto simples e precisa garantir que todas as variáveis obrigatórias estão lá antes de subir um container.
#
# O Desafio:
#
# Defina um array indexado chamado REQUIRED_VARS com os nomes: DB_HOST, DB_USER, DB_PASS, API_KEY.
#
# O script deve ler um arquivo chamado config.env.
#
# Lógica Avançada: * Para cada variável no array REQUIRED_VARS, use grep ou um laço para verificar se ela existe no arquivo e se possui um valor atribuído (ex: DB_HOST=localhost é válido, DB_HOST= não é).
#
# Use expansão de variáveis ${var:-default} ou ${var:?error} para validar a presença.
#
# Se algo estiver faltando, o script deve sair com exit 1 e listar todas as variáveis ausentes.

FILE_PATH="./config.env"

REQUIRED_VARS=(
	DB_HOST
	DB_USER
	DB_PASS
	API_KEY
)

declare -a missing_vars

for var in "${REQUIRED_VARS[@]}"; do
	file_grep=$(cat $FILE_PATH | grep $var)
	var=${file_grep%=*}
	value=${file_grep#*=}
	final_value=${value:-"default_value"}
	# final_value=${value:="default_value"} alteraria o valor de value em caso positivo
	# echo "${value:? "erro"}" # isso para o programa nesse ponto caso a variável seja vazia
	if [[ $final_value == "default_value" ]]; then
		missing_vars+=(var)
	fi
done

if [[ ${#missing_vars[*]} -gt 0 ]]; then
	echo "Variáveis inadequadas:"
	echo "${missing_vars[*]}"
	exit 1
fi
