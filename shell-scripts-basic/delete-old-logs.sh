#!/bin/bash

DIRECTORY=/vat/tmp

if [ -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does exist."
else 
    echo "$DIRECTORY doesn't exist"
fi
