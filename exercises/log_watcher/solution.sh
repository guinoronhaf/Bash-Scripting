#!/bin/bash

declare -A err_count
declare -a blacklist

ip_status=$(cat ./access.log | awk '{print $1 "-" $9}')

for ip_st in $ip_status; do
	ip=${ip_st%-*}
	status="${ip_st#*-}"
	if [[ "$status" == "401" || "$status" == "403" ]]; then
		if [[ -v err_count[$ip] ]]; then
			count=${err_count[$ip]}
			((count++))
			err_count[$ip]=$count
			if [[ ${err_count[$ip]} -gt 5 ]]; then
				blacklist+=("$ip")
			fi
		else
			err_count[$ip]=1
		fi
	fi
done

echo "IPs bloqueados:"

for blocked_ip in "${blacklist[@]}"; do
	echo "$blocked_ip"
done
