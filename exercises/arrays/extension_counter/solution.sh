#!/bin/bash

# Crie um script que analise os arquivos do diretório atual:
#
# Use um comando (como ls ou um glob *) para guardar todos os nomes de arquivos em um array indexado.
#
# Percorra esse array e, para cada arquivo, extraia a extensão (ex: .txt, .sh, .jpg).
#
# Use um array associativo para contar quantas vezes cada extensão aparece. A chave será a extensão e o valor será o contador.
#
# Ao final, exiba um relatório das extensões encontradas.

# Para tratar substrings em Bahs, existem algumas formas possíveis. Nativamente, os recursos usando % (ou %%) e # (ou ##) conseguem dar conta do recado. É o que se chama de parameter expression
#
# Basicamente, ao fazer ${file%.*}, deve-se remover tudo que vier depois do ponto.Se quiser a primeira ocorrência do padrão, deve-se usar %%.
#
# Já ao fazer ${file#*.}, busca-se pela menor ocorrência do padrão (.);
# Por outro lado, ${file##*.} vai em busca da maior ocorrência do padrão.

declare -A exts_counter

# IMPORTANTE: caso o nome dos arquivos venha com ./arq.extensao, apenas o ponto do começo (diretório atual) será removido.

for file in ./*; do
	file_ext=${file##*.} # como usei ./*, tenho que usar ## aqui
	if [[ -v exts_counter[$file_ext] ]]; then
		current_value=${exts_counter[$file_ext]}
		exts_counter[$file_ext]=$(( current_value+1 ))
	else
		exts_counter[$file_ext]=1
	fi
done

echo "=== RELATÓRIO ==="

for key in "${!exts_counter[@]}"; do
	k_value=${exts_counter[$key]}
	echo "Extensão $key: $k_value file(s)"
done
