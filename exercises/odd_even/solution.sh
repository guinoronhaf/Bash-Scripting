#!/bin/bash

n=$1
n_mod=$(( $n % 2 ))

test $n_mod -eq 0 && echo "even" || echo "odd"
