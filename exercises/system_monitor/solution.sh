#!/bin/bash

hostname=$(hostname)
kernel_version=$(uname -r)
mem_use=$(free -Lh)
disc_use=$(df -h | awk '{print $1, $5}')

echo "Nome da máquina: $hostname"
echo "Versão do kernel: $kernel_version"
echo "Uso de memória: $mem_use"
echo "Espaço disponível: $disc_use"
