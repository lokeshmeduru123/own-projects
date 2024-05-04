#!/bin/bash

COURCE="Devops from current script"

echo "Before calling other script, $COURCE"
echo "Process ID of current script is $$"

./other-script.sh

echo "After calling other script, $COURCE"

# using source 
echo "Using source to call the script"

Source ./other-script.sh

echo "After calling other script, $COURCE"
