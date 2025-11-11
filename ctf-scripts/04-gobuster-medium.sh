#!/bin/bash
set -e

if [ ! -f target.txt ]; then
    echo "Error: target.txt not found. Run 00-create-vars.sh first."
    exit 1
fi

if ! command -v gobuster &> /dev/null; then
    echo "Error: gobuster is not installed"
    exit 1
fi

if [ ! -f /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt ]; then
    echo "Error: SecLists wordlist not found. Install with: sudo apt install seclists"
    exit 1
fi

target=$(< target.txt)
echo "Input target URL (e.g., / or /admin):"
read url

# Default to root if empty
if [ -z "$url" ]; then
    url="/"
fi

# Ensure URL starts with /
if [[ ! "$url" =~ ^/ ]]; then
    url="/$url"
fi

full_url="http://$target$url"
echo "Scanning: $full_url"

strip="$(echo "$url" | tr -d "/")"
if [ -z "$strip" ]; then
    strip="root"
fi

gobuster dir -u "$full_url" -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o "gobuster-medium-$strip" -t 30
echo "Scan complete. Results saved to gobuster-medium-$strip"
