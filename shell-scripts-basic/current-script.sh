#!/bin/bash

COURCE="Devops from current script"

echo "Before calling other script, $COURCE"
echo "Process ID of current script is $$"

./other-script.sh

echo "After calling other script, $COURCE"

# using source 
echo "Using sorce to call the script"

Sorce ./other-script.sh

echo "After calling other script, $COURCE"
