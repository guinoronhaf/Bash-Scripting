#!/bin/bash

# Declarar um array associativo usuarios.
#
# Adicionar 3 pares de usuario="senha" (ex: [admin]="1234", [root]="segredo").
#
# Solicitar ao usuário o nome de login.
#
# Verificar se a chave existe no array. Se não existir, exibir "Usuário inexistente".
#
# Se existir, solicitar a senha e comparar com o valor armazenado no array.
#
# Exibir "Acesso Garantido" ou "Senha Incorreta".

declare -A usuarios

usuarios[admin]="1234"
usuarios[root]="segredo"
usuarios[guilherme]="senha_teste"

echo -n "Login: "
read login

if [ -v usuarios[$login] ]; then
	senha_cadastrada=${usuarios[$login]}
	echo -n "Senha: "
	read senha
	if [ $senha == $senha_cadastrada ]; then
		echo "Acesso permitido!"
	else
		echo "Seha incorreta. Acesso negado."
	fi
else
	echo "Usuário inexistente.";
fi
