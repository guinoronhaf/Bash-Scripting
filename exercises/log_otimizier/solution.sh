#!/bin/bash

# Cenário: O diretório /var/log (ou uma simulação dele) está enchendo. Você precisa de um script que tome decisões baseadas no tamanho dos arquivos.
#
# Use um laço for para iterar sobre arquivos .log em um diretório.
#
# Para cada arquivo, obtenha o tamanho em bytes usando substituição de comando (ex: stat -c%s).
#
# Expressão Aritmética: Converta o tamanho para Kilobytes ($KB = bytes / 1024$).
#
# Condição: * Se o arquivo for maior que 100KB, comprima-o usando gzip.Se for menor que 100KB mas maior que 10KB, apenas renomeie adicionando a data atual ao nome.Se for menor que 10KB, ignore.

LOG_PATH=./sim_logs
DATE=$(date +%F)

for file in $LOG_PATH/*.log; do
	file_name_ext=${file##*/}
	bytes_size=$(stat -c%s $file)
	kb_size=$(( bytes_size / 1024 ))
	if [[ $kb_size -gt 100 ]]; then
		echo "$file_name_ext possui mais de 100KB. Zipando..."
		sudo gzip $file
		# echo "mais de 100"
	elif [[ $kb_size -gt 10 ]]; then
		file_name=${file_name_ext%.*}
		new_file_name="$LOG_PATH/$file_name$DATE.log"
		mv $file $new_file_name
		echo "Entre 100 e 10. Renomeando $file_name_ext para $new_file_name..."
	else
		echo "Menos de 10. Ok."
	fi	
done
