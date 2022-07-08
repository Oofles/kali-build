#!/bin/bash

target=$(< target.txt)
echo "Input target URL:"
read url

gobuster dir -u http://$target$url -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o gobuster-medium -t 30
