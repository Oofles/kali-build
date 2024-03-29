#!/usr/bin/env python3
"""Command-line interface to perform several security tests."""

import whois
import typer
import nmap3

app = typer.Typer()


@app.command()
def domain(name: str):
    """Print the domain registrant's name and organization."""
    results = whois.whois(name)
    print(f"{name} is registered by {results.name} - {results.org}")

@app.command()
def portscan(target: str, top: int = 10):
    """Perform a portscan against a target on the top TOP ports,
    and print the open ports and services."""
    nmap = nmap3.Nmap()
    results = nmap.scan_top_ports(target, default = top)
    ip, *_unused = results.keys()
    for port in results[ip]["ports"]:
        if "open" in port["state"]:
            print(f"{port['portid']} {port['service']['name']}")


if __name__ == "__main__":
    app()