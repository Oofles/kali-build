#!/usr/bin/env python3
"""Command-line interface to perform several security tests."""

import sys
import whois
import typer
import nmap3

app = typer.Typer()


@app.command()
def domain(name: str):
    """Print the domain registrant's name and organization."""
    try:
        results = whois.whois(name)
        if results.name and results.org:
            print(f"{name} is registered by {results.name} - {results.org}")
        else:
            print(f"Domain: {name}")
            if results.name:
                print(f"Registrant: {results.name}")
            if results.org:
                print(f"Organization: {results.org}")
            if not results.name and not results.org:
                print("No registrant information available")
    except Exception as e:
        print(f"Error: Unable to retrieve WHOIS information for {name}")
        print(f"Details: {str(e)}")
        sys.exit(1)


@app.command()
def portscan(target: str, top: int = 10):
    """Perform a portscan against a target on the top TOP ports,
    and print the open ports and services."""
    try:
        nmap = nmap3.Nmap()
        print(f"Scanning top {top} ports on {target}...")
        results = nmap.scan_top_ports(target, default=top)

        # Get the first key (IP address)
        keys = list(results.keys())
        if not keys:
            print("Error: No results returned from scan")
            sys.exit(1)

        ip = keys[0]

        # Check if the scan was successful
        if "ports" not in results[ip]:
            print(f"Error: Unable to scan {target}")
            sys.exit(1)

        open_ports = []
        for port in results[ip]["ports"]:
            if "open" in port["state"]:
                open_ports.append(f"{port['portid']} {port['service']['name']}")

        if open_ports:
            print(f"\nOpen ports on {target}:")
            for port_info in open_ports:
                print(f"  {port_info}")
        else:
            print(f"No open ports found on {target}")

    except KeyError as e:
        print(f"Error: Unexpected scan result format")
        print(f"Details: {str(e)}")
        sys.exit(1)
    except Exception as e:
        print(f"Error: Unable to scan {target}")
        print(f"Details: {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    app()