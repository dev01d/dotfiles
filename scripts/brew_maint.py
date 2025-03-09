#!/usr/bin/env python3
import os
import subprocess


def blue(text):
    return "\033[34m{} \033[0m".format(text)


def green(text):
    return "\033[32m{} \033[0m".format(text)


def red(text):
    return "\033[31m{} \033[0m".format(text)


def runBrewMaint():
    print(blue("\n--> Brew upgrade casks\n"))
    subprocess.run("brew cu -facy --cleanup", shell=True, check=True)

    homeDir = os.path.expanduser("~")
    brew = homeDir + "/.config/brewfile"
    os.chdir(brew)
    validBrew = os.path.isfile(brew + "/Brewfile")

    if validBrew:
        print(blue("\n--> Update Brewfile\n"))
        subprocess.run("brew bundle dump --cleanup -f", shell=True, check=True)
        print(green("✨ Done!"))
    else:
        print(red("Can't get Brewfile location"))

    print(blue("\n--> Brew install from Brewfile\n"))
    subprocess.run("brew bundle --cleanup", shell=True, check=False)

    print(blue("\n--> Brew update\n"))
    subprocess.run("brew update", shell=True, check=True)

    print(blue("\n--> Brew upgrade\n"))
    subprocess.run("brew upgrade", shell=True, check=True)

    print(blue("\n--> Brew cleanup\n"))
    subprocess.run("brew cleanup", shell=True, check=True)


def main():
    runBrewMaint()
    print(green("\n✨ Done!\n"))


if __name__ == "__main__":
    main()
