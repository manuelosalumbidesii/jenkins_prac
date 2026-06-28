#!/usr/bin/env bash

# Script name: monitor.sh
# Purpose: Run 'top' for 5 seconds and save output to a log file

echo "Running top for 5 seconds..."
top -l 1 > top_output.log   # sa macOS, '-l 1' = run top once
echo "Output saved to top_output.log"

