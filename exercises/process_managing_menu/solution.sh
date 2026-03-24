#!/bin/bash

# exemplo de sintaxe while loop
# -----
# i=1
# while [ $i -lt 10 ];
# do
# 	echo $i
# 	i=$((i +1))
# done

echo "===== MENU INTERATIVO DE GESTÃO DE PROCESSOS ====="
while true;
do
	echo "Selecione uma opção:"
	echo "1 - Listar todos os processos ativos."
	echo "2 - Verificar se um processo está rodando pelo nome."
	echo "3 - Sair."
	echo -n "> "
	read input
	case $input in

		1)
			echo "Listando todos os processos..."
			sleep 2
			ps -u $USER
			;;
		
		2)
			echo -n "Nome do processo: "
			read proc_name
			if ps -u $USER | grep $proc_name &> /dev/null;
			then
				echo "Processo rodando!"
			else
				echo "Processo não está rodando!"
			fi
			;;
		
		3)
			echo "Saindo..."
			sleep 1.5
			break
			;;
		
		*)
			echo "Opção Inválida. Tente novamente."
			;;

	esac
done
