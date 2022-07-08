#!/bin/bash

/usr/bin/nmap -v -sC -sV -oN nmap-quick -iL target.txt
