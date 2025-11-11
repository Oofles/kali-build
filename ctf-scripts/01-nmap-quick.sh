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

echo "Running quick nmap scan..."
/usr/bin/nmap -v -sC -sV -oN nmap-quick -iL target.txt
echo "Scan complete. Results saved to nmap-quick"
