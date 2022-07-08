#!/bin/bash

target=$(< target.txt)
echo "Input target URL:"
read url
domain=http://
domain+=$target
domain+=$url
echo "$domain"

gobuster dir -u $domain -w /usr/share/seclists/Discovery/Web-Content/common.txt -o gobuster-common -t 30
