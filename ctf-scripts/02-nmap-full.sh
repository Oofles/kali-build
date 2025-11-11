#!/bin/bash
set -e

if [ ! -f target.txt ]; then
    echo "Error: target.txt not found. Run 00-create-vars.sh first."
    exit 1
fi

if ! command -v nmap &> /dev/null; then
    echo "Error: nmap is not installed"
    exit 1
fi

echo "Running full port scan (this may take a while)..."
/usr/bin/nmap -v -p- -oN nmap-full -iL target.txt
echo "Scan complete. Results saved to nmap-full"
