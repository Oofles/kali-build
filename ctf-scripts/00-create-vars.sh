#!/bin/bash
set -e

# Validate IP address format
validate_ip() {
    local ip=$1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        return 0
    else
        return 1
    fi
}

echo "Input target IP:"
read target

if ! validate_ip "$target"; then
    echo "Error: Invalid IP address format"
    exit 1
fi

echo "$target" > target.txt
echo "Target IP saved to target.txt"

echo "Input local IP:"
read self

if ! validate_ip "$self"; then
    echo "Error: Invalid IP address format"
    exit 1
fi

echo "$self" > self.txt
echo "Local IP saved to self.txt"
