#!/bin/bash

# Cenário: Um servidor de aplicação está deixando processos "pendurados" que consomem memória sem necessidade.
#
# O Desafio:
#
# Liste todos os processos de um determinado usuário (ou um nome de processo específico) usando ps.
#
# Para cada processo, verifique há quanto tempo ele está rodando (coluna etime).
#
# Substituição de Comando: Converta o tempo do etime (que vem em MM:SS ou HH:MM:SS) para total de segundos usando aritmética do Bash.
#
# Lógica: Se o processo estiver rodando há mais de 3600 segundos (1 hora), dispare um kill -15 (simulado com echo).
#
# Mantenha um contador de quantos processos foram finalizados e exiba o total ao final.

SEC_LIMIT=10
# NR denota número do registro atual. Com NR > 1, estamos pegando tudo menos a primeira linha
processes=$(ps -u $USER | awk 'NR>1 {print $3 "/" $4}')

for proc in $processes; do
	raw_time=${proc%/*}
	proc_name=${proc#*/}
	# -----
	time_min_sec=${raw_time#*:}
	min=${time_min_sec%:*}
	sec=${time_min_sec#*:}
	total_sec=$(( (min * 60) + sec ))
	# -----
	if [[ $total_sec -gt $SEC_LIMIT ]]; then
		echo "Processo $proc_name encerrado."
	fi
done
