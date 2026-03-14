#!/bin/bash

login_us="bash"
login_pswd="linux"

login_input_us=$1
login_input_pswd=$2

# ao comparar strings, sempre com ==
if [ "$login_input_us" == $login_us -a "$login_input_pswd" == $login_pswd ]; then
	echo "Acesso garantido"
else
	echo "Acesso negado"
fi
