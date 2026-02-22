#!/bin/bash

# uso do read:
read name age

echo "Olá, $name! Você tem $age ano(s) e em 10 anos terá $(( age + 10 ))."

# $(comando): subshell, isto é, executa o comando e substitui o resultado na linha de comando.
# Ex.: data_atual=$(date)
#
# $((exp)): utilizado para expressões aritméticas.
# Ex.: total=$((10 + 5))
