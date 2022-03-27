#!/usr/bin/env python3

import subprocess


def blue(text):
    return "\033[34m{} \033[0m".format(text)


def green(text):
    return "\033[32m{} \033[0m".format(text)


def runBrewMaint():
    print(blue("\n--> Brew upgrade casks\n"))
    subprocess.run("brew cu -facy --cleanup", shell=True, check=True)

    print(blue("\n--> Update Brewfile\n"))
    subprocess.run("brew bundle dump --cleanup -f", shell=True, check=True)

    print(blue("\n--> Brew install from Brewfile\n"))
    subprocess.run("brew bundle --cleanup --no-lock",
                   shell=True, check=True)


def main():
    runBrewMaint()
    print(green("\n✨ Done!\n"))


if __name__ == "__main__":
    main()
