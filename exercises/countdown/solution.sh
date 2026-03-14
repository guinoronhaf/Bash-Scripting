#!/bin/bash

n_end=$1

# for n in {$n_end..0..-1} -> notação não suportada para uso com variáveis
for ((n=$n_end; n >= 0; n+=-1))
do
	echo $n
	sleep 1
done
