#!/bin/bash

# Cenário: Gerar um snapshot rápido do consumo de memória para um relatório gerencial.Capture a memória total e a memória usada do sistema usando o comando free e substituição de comando.Dica de substituição: Use awk ou cut para extrair apenas os números.Expressão Aritmética: Calcule a porcentagem de uso de memória:$$\% \text{uso} = \left( \frac{\text{usada} \times 100}{\text{total}} \right)$$Condição: Exiba uma barra de progresso visual simples. Se o uso for $> 80\%$, exiba "STATUS: CRÍTICO". Se for entre $50\%$ e $80\%$, "STATUS: ALERTA". Abaixo disso, "STATUS: NORMAL".

mem_total=$(free | grep "Mem" | awk '{print $2}')
mem_used=$(free | grep "Mem" | awk '{print $3}')

# aqui, a expressão $(( (mem_used * 100) / mem_total )) é aceitável, ainda que redundante
perc_usage=$(( mem_used * 100 / mem_total ))

if [[ $perc_usage -gt 80 ]]; then
	echo "crítico"
elif [[ $perc_usage -ge 50 ]]; then
	echo "alerta"
else
	echo "normal"
fi

n_symbols=$(( perc_usage / 10 ))

echo -n "["

for i in {1..10}; do
	if [[ $i -le $n_symbols ]]; then
		echo -n "="
	else
		echo -n " "
	fi
done

echo "]"
