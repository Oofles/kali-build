# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a Kali Linux setup and pentesting toolkit repository used for:
- Documenting Kali Linux build/rebuild procedures
- Storing commonly used CTF and penetration testing scripts
- Housing OSCP preparation materials, particularly buffer overflow exploitation

## Repository Structure

```
kali-build/
├── ctf-scripts/        # Automated reconnaissance scripts for CTF challenges
├── buffer-overflow/    # Buffer overflow exploitation templates and guides
└── python-scripts/     # Python-based security testing tools
```

### ctf-scripts/
Sequential bash scripts designed to be run in order during CTF challenges:
- `00-create-vars.sh` - Initialize target and local IP variables (creates target.txt and self.txt)
- `01-nmap-quick.sh` - Fast service scan with -sC -sV (reads from target.txt)
- `02-nmap-full.sh` - Full port scan -p- (reads from target.txt)
- `03-gobuster-common.sh` - Directory enumeration with common wordlist
- `04-gobuster-medium.sh` - Directory enumeration with medium wordlist

**Workflow**: Run 00-create-vars.sh first to set target IP, then subsequent scripts read from target.txt automatically.

### buffer-overflow/
Contains `bof-complete.py` - a structured template for local buffer overflow exploitation following the standard 6-part methodology:
1. Fuzzing to find crash point
2. Control EIP with pattern_create/pattern_offset
3. Set offset and verify EIP control
4. Expand stack space (100-200 bytes needed)
5. Identify bad characters via ESP dump
6. Find JMP ESP, generate shellcode with msfvenom, add NOP slide

**Critical reminder**: Addresses must be reversed due to little-endian byte order.

### python-scripts/
`recon.py` - CLI tool using typer for:
- `domain` command: WHOIS lookups
- `portscan` command: nmap top port scanning

Dependencies: whois, typer, nmap3

## Initial Kali Setup Commands

When setting up a fresh Kali build, run these in order:

```bash
# Update system
sudo apt update && sudo apt upgrade
sudo apt dist-upgrade

# Enable remote access
sudo apt install -y xrdp
sudo systemctl enable xrdp && sudo systemctl start xrdp
sudo systemctl enable ssh && sudo systemctl start ssh

# Install essential tools
sudo apt install -y gobuster seclists gh

# Configure GitHub
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
gh auth login  # optional
```

## Common Tool Locations

- SecLists wordlists: `/usr/share/seclists/`
- Common wordlist: `/usr/share/seclists/Discovery/Web-Content/common.txt`
- Medium wordlist: `/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt`

## Security Context

This repository contains authorized security testing tools for:
- CTF competitions
- OSCP certification preparation
- Penetration testing engagements
- Educational security research

All scripts are designed for controlled environments with proper authorization.
