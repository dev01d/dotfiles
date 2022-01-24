#!/usr/bin/env python3
import os
import subprocess
import shutil
from time import sleep


def blue(text):
    return "\033[34m{} \033[0m".format(text)


def green(text):
    return "\033[32m{} \033[0m".format(text)


def red(text):
    return "\033[31m{} \033[0m".format(text)


def yellow(text):
    return "\033[93m{} \033[0m".format(text)


def instalBrew():
    print(blue("\n--> Installing brew"))
    brewInstall = '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'
    validPath = os.path.isfile("/opt/homebrew/bin/brew")
    if validPath:
        print(green("\n\tBrew already installed"))
    else:
        subprocess.run(brewInstall, shell=True, check=True)


def installBrewApps():
    print(blue("\n--> Brew bundle install\n"))

    # Stop user and ask to sign into appstore
    answer = input(yellow('\tIs this the first run?: [y/n]: '))
    if not answer or answer[0].lower() != "n":
        print(yellow('\n\tPlease sign into the App Store. Opening App Store now.'))
        sleep(3)
        subprocess.run("open -a 'App Store'", shell=True, check=True)
        input(yellow('\n\tPress Enter to continue'))
    print(blue("\n--> Continuing install\n"))
    sleep(3)
    subprocess.run(
        "brew bundle --quiet --file ./brew/Brewfile --cleanup --no-lock", shell=True, check=True)


def installOMZSH():
    print(blue("\n--> Installing Oh My ZSH"))
    omzsh = 'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
      && git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autoupdate'
    homeDir = os.path.expanduser("~")
    omzshpath = homeDir + "/.oh-my-zsh"
    validPath = os.path.isdir(omzshpath)
    if validPath:
        print(green("\n\tOMZSH is already installed"))
    else:
        subprocess.run(omzsh, shell=True, check=True)


def makeSymlinks():
    homeDir = os.path.expanduser("~")
    cwd = os.getcwd()
    oldDir = homeDir + "/.dotfiles_old"
    nvimDir = homeDir + "/.config/nvim"
    validPath = os.path.isdir(oldDir)
    validNvimPath = os.path.isdir(nvimDir)
    files = (
        "zshrc",
        "vimrc",
        "aliases",
        "p10k.zsh",
        "gitconfig",
        "global_gitignore",
    )

    if validPath:
        shutil.rmtree(oldDir, ignore_errors=True)
        os.mkdir(oldDir)
    else:
        os.mkdir(oldDir)

    if not validNvimPath:
        os.mkdir(nvimDir)
        os.symlink("%s/%s" % (cwd, "init.vim"), "%s/%s" %
                   (nvimDir, "init.vim"))

    # Intentionally non destructive
    for file in files:
        if os.path.isfile(homeDir + "/." + file):
            shutil.move("%s/.%s" % (homeDir, file), oldDir)
        else:
            pass

    for file in files:
        os.symlink("%s/%s" % (cwd, file), "%s/.%s" % (homeDir, file))


def main():
    makeSymlinks()
    instalBrew()
    installOMZSH()
    installBrewApps()
    if not os.path.isfile("/etc/whois.conf"):
        print(yellow("\tSudo access needed to install better ntld support\n"))
        subprocess.run(
            "sudo wget -nc https://www.unpm.org/whois.conf -O /etc/whois.conf", shell=True, check=False)


if __name__ == "__main__":
    main()
