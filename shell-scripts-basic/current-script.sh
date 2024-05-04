#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"

COURCE="Devops from current script"

echo "Before calling other script, $COURCE"
echo "Process ID of current script is $$"

./other-script.sh

echo "After calling other script, $COURCE"

# using source 
echo -e "$G Using source to call the script $N"

source ./other-script.sh

echo "After calling other script, $COURCE"
