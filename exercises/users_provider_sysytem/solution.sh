#!/bin/bash

# Cenário: Você recebeu uma lista bruta de novos funcionários e precisa validar se os nomes de usuário são válidos antes de criá-los no sistema.
#
# Crie um array indexado com uma lista de nomes (ex: joao.silva, admin, root, maria.oliveira).
#
# Crie um segundo array chamado reservados contendo ("root" "admin" "bin").
#
# O Desafio: Percorra a lista de novos funcionários. Para cada um:
#
# Verifique se o nome já existe no array de nomes reservados.
#
# Verifique se o nome tem menos de 3 caracteres.
#
# Se passar nas validações, exiba: "Usuário [NOME] pronto para criação".
#
# Caso contrário, exiba um erro específico para cada falha.

users=(
	joao.silva
	admin
	root
	maria.oliveira
)

unavailable=(
	"root",
	"admin",
	"bin"
)

for u in "${users[@]}"; do
	if [[ ${unavailable[@]} =~ $u ]]; then
		echo "Nome de usuário reservado"
	elif [ ${#u} -lt 3 ]; then
		echo "Nome com menos de 3 caracteres."
	else
		echo "Usuário $u pronto para criação!"
	fi
done
