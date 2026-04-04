#!/bin/bash

# Cenário: Você precisa garantir que arquivos de configuração críticos (como /etc/passwd ou um .env de produção) não foram alterados por um invasor.
#
# O Desafio:
#
# Crie um array indexado com os caminhos de 3 arquivos (ex: config.env, access.log, e um arquivo teste.txt).
#
# Primeira Execução: O script deve gerar o hash sha256sum de cada arquivo e armazená-lo em um array associativo (ou em um arquivo de "banco de dados" temporário).
#
# Segunda Execução (Verificação): O script deve gerar o hash novamente e comparar com o valor armazenado.
#
# Lógica: Se o hash for diferente, exiba um alerta: [PERIGO] O arquivo X foi modificado!. Se for igual, exiba [OK].

declare -A files_hash

files_path=(
	./config.env
	./deploy.sh
	./auth_list.txt
)

# -- primeira execução --
for file in "${files_path[@]}"; do
	if ! [[ -v files_hash[$file] ]]; then
		hash=$(sha256sum $file | awk '{print $1}')
		files_hash[$file]=$hash
	fi
done

# -- segunda execução --
for file in "${!files_hash[@]}"; do
	prev_hash=${files_hash[$file]}
	curr_hash=$(sha256sum $file | awk '{print $1}')
	if [[ "$prev_hash" != "$curr_hash" ]]; then
		echo "[PERIGO] O arquivo $file foi modificado!"
	else
		echo "[OK]"
	fi
done
