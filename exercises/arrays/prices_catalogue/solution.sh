#!/bin/bash

# Crie um script que funcione como um mini sistema de consulta:
#
# Declare um array associativo chamado produtos.
#
# Popule o array com 4 produtos (chave) e seus preços (valor). Ex: [teclado]=150.
#
# Pergunte ao usuário qual produto ele deseja consultar.
#
# Se o produto existir no array, exiba: "O preço de [produto] é R$ [valor]".
#
# Se não existir, exiba: "Produto não encontrado".

declare -A produtos

produtos[teclado]=150
produtos[mouse]=100
produtos[monitor]=600
produtos[gabinete]=300

read prod

# verificando existência da chave
if [[ -v produtos[$prod] ]]; then
	valor="${produtos[$prod]}"
	echo "O preço de $prod é RS $valor"
else
	echo "Produto não encontrado."
fi
