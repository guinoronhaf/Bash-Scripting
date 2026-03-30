#!/bin/bash

# Cenário: Você precisa monitorar a disponibilidade de diferentes APIs e armazenar o status de cada uma.
#
# Crie um array associativo onde a chave é o nome do serviço (ex: "Auth", "Payments", "Email") e o valor é a URL do endpoint de health check.
#
# Use um laço para percorrer o array e valide a conexão usando curl (ou similar) via substituição de comando.
#
# Lógica: Se o status code for 200, exiba "[OK] Servidor Ativo". Caso contrário, armazene o nome do serviço em um array indexado chamado servicos_caidos.
#
# Ao final, se o array servicos_caidos não estiver vazio, exiba um alerta em vermelho listando todos os serviços que precisam de atenção.

RED='\033[0;31m'
NOCOLOR='\033[0m'

declare -A endpoints
declare -a unav_endpoints

endpoints["Auth"]="https://jsonplaceholder.typicode.com/posts/1"
endpoints["Payment"]=""https://jsonplaceholder.typicode.com/users/1
endpoints["Email"]="https://jsonplaceholder.typicode.com/erro-proposital"
endpoints["Login"]="https://jsonplaceholder.typicode.com/erro-proposital"

for service in "${!endpoints[@]}"; do
	url=${endpoints[$service]}
	status_req=$(curl -s -I $url | grep "HTTP/2")
	status_code=${status_req#* }
	status_code_form=${status_code% *}
	if [[ "$status_code_form" == "200" ]]; then
		echo "[OK] Servidor Ativo"
	else
		unav_endpoints+=($service)
	fi
done

if [[ ${#unav_endpoints[*]} -gt 0 ]]; then
	echo "SERVIÇOS PARA ATENÇÃO:"
	echo -e "${RED}${unav_endpoints[*]}${NCOLOR}"
else
	echo "Todos os serviços OK."
fi
