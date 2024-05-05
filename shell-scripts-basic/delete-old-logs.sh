#!/bin/bash

DIRECTORY=/tmp/loki-logs

if [ -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does exist."
else 
    echo "$DIRECTORY doesn't exist"
fi
