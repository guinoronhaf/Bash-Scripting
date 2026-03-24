#!/bin/bash

age=10

if [[ "$age" -gt 10 && "$age" -gt 20 ]]; then
    echo "greater than 10 and greater than 20"
else
    echo "false"
fi
