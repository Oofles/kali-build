# kali-build
Eventually Kali becomes a bit bloated and needs to be reimaged to continue functioning properly. This repo helps document my setup steps and hosts some of my more commonly used scripts and files.

## New Build - Intial Setup Steps
1. Update/Upgrade:
```bash
sudo apt update
sudo apt upgrade
```

2. Clone this repo:
```bash
git clone https://github.com/Oofles/kali-build.git
```

3. Install additional packages:
```bash
sudo apt install -y gobuster seclists
```

4. Firefox extensions:
    a. HackTools: https://addons.mozilla.org/en-US/firefox/addon/hacktools/
    b. FoxyProxy: https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/

5. Configure FoxyProxy (Settings):
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