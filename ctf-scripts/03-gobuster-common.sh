#!/bin/bash

target=$(< target.txt)
echo "Input target URL:"
read url
domain=http://
domain+=$target
domain+=$url
echo "$domain"

strip=echo $url | tr -d

gobuster dir -u $domain -w /usr/share/seclists/Discovery/Web-Content/common.txt -o gobuster-common-$strip -t 30
