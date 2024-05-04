#!/bin/bash

COURCE="Devops from current script"

echo "Before calling other script, $COURCE"
echo "Process ID of current script is $$"

./other-script.sh

echo "Before calling other script, $COURCE"
