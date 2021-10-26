#!/usr/bin/env python3
import subprocess


def runBrewMaint():
    print("\n--> Brew install from Brewfile", flush=True)
    subprocess.run("brew bundle --cleanup --no-lock", shell=True, check=True)

    print("\n--> Brew upgrade casks", flush=True)
    subprocess.run("brew cu -facy --cleanup", shell=True, check=True)

    print("\n--> Update Brewfile", flush=True)
    subprocess.run("brew bundle dump -f", shell=True, check=True)


def main():
    runBrewMaint()


if __name__ == "__main__":
    main()