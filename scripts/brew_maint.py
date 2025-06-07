#!/usr/bin/env python3
import os
import subprocess
import argparse


# --- Color functions ---
def blue(text):
    return "\033[34m{}\033[0m".format(text)


def green(text):
    return "\033[32m{}\033[0m".format(text)


def red(text):
    return "\033[31m{}\033[0m".format(text)


def yellow(text):
    return "\033[93m{}\033[0m".format(text)


homeDir = os.path.expanduser("~")
brew = homeDir + "/.config/brewfile"
os.chdir(brew)
validBrew = os.path.isfile(brew + "/Brewfile")


def updateBrewfile():
    print(blue("\n---> Update Brewfile"))
    subprocess.run("brew bundle dump -f --cleanup --upgrade", shell=True, check=True)
    print(green("\n✨ Brewfile updated!\n"))


def runBrewMaint():
    print(blue("\n---> Brew Update"))
    subprocess.run("brew update", shell=True, check=True)

    print(blue("\n---> Brew Upgrade Casks"))
    subprocess.run("brew cu -fay --cleanup --include-mas", shell=True, check=True)

    print(blue("\n---> Brew Upgrade"))
    subprocess.run("brew upgrade", shell=True, check=True)

    print(blue("\n---> Remove anything not in Brewfile"))
    subprocess.run("brew bundle cleanup -f", shell=True, check=False)

    if validBrew:
        updateBrewfile()
    else:
        print(red("Can't get Brewfile location"))

    print(blue("\n---> Brew Cleanup"))
    subprocess.run("brew cleanup -s ", shell=True, check=True)


def main():
    parser = argparse.ArgumentParser(description="Homebrew maintenance script")
    parser.add_argument(
        "-u",
        "--update",
        "--update-brewfile",
        dest="update_brewfile",
        action="store_true",
        help="Only update the Brewfile and exit",
    )
    args = parser.parse_args()

    if args.update_brewfile:
        if validBrew:
            updateBrewfile()
            runBrewMaint()
        else:
            print(red("Can't get Brewfile location"))
    else:
        runBrewMaint()
        print(green("\n✨ Done!\n"))


if __name__ == "__main__":
    main()
