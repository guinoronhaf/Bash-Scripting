#!/bin/bash

# Crie um script que:
#
# Declare um array indexado chamado compras.
#
# Adicione três itens à lista via script.
#
# Peça para o usuário digitar mais um item e adicione-o ao array.
#
# Remova o segundo item da lista.
#
# Imprima o total de itens e, em seguida, cada item numerado (ex: "1. Arroz").

compras=(macarrao carne feijao)

read item

compras+=($item)

unset compras[1]

total_itens="${#compras[*]}"

echo "Qtde. de itens: $total_itens"

idx=1

for prod in "${compras[@]}"; do
	echo "$idx. $prod"
	idx=$(( $idx+1 ))
done
