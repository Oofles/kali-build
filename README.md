# kali-build
Eventually Kali becomes a bit bloated and needs to be reimaged to continue functioning properly. This repo helps document my setup steps and hosts some of my more commonly used scripts and files.

## New Build - Intial Setup Steps
1. Update/Upgrade:
```bash
sudo apt update && sudo apt upgrade
sudo apt dist-upgrade
```

2. Enable RDP and SSH:
```bash
# RDP
sudo apt install -y xrdp
sudo systemctl enable xrdp
sudo systemctl start xrdp

# SSH
sudo systemctl enable ssh
sudo systemctl start ssh
```

3. GitHub Setup:
```bash
# Clone this repo:
git clone https://github.com/Oofles/kali-build.git

# Optional: Authenticate to GitHub:
sudo apt install -y gh
gh auth login
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

4. Install additional packages:
```bash
sudo apt install -y gobuster seclists
```

5. Firefox extensions:

    a. HackTools: https://addons.mozilla.org/en-US/firefox/addon/hacktools/
    b. FoxyProxy: https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/

6. Configure FoxyProxy (Settings):
- Title: Burp
- Proxy Type: HTTP
- Proxy IP: 127.0.0.1
- Port: 8080



---

## Troubleshooting

### DNS not working
Barebones install - can ping out, but not resolve hostnames
- If the NIC drivers aren't installed properly or there's an issue during build, the resolv.conf file may be misconfigured

```bash
sudo -i
rm -rf /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
exit
```

After reboot (or network service restart), DHCP may pick up and modify the resolv.conf to the desired DNS servers.
