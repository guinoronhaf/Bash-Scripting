#!/bin/bash

n_end=$1

for n in {$n_end..0..-1}
do
	echo $n
	sleep 1
done
