#!/bin/bash

process=$(ps -eo pid,%cpu,comm --sort=-%cpu | head -n 6)

echo "Top 5 cpu consuming process : $process"
