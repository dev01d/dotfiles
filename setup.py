#!/usr/bin/env python3
import os
import subprocess
import shutil


def instalBrew():
    print("\n--> Installing brew", flush=True)
    brewInstall = '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'
    validPath = os.path.isdir("/usr/local/bin/brew")
    if validPath:
        subprocess.run(brewInstall, shell=True, check=True)
    else:
        print("Brew already installed")


def installBrewApps():
    subprocess.run("brew bundle --cleanup --no-lock", shell=True, check=True)


def installOMZSH():
    print("\n--> Installing Oh My ZSH", flush=True)
    omzsh = 'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
      git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autoupdate'
    os.getcwd()
    path = "../.oh-my-zsh"
    status = subprocess.call("test -e '{}'".format(path), shell=True)
    validPath = os.path.isdir(path)
    if validPath:
        subprocess.run(omzsh, shell=True, check=True)
    else:
        print("OMZSH is already installed")


def makeSymlinks():
    homeDir = os.path.expanduser("~")
    newDir = os.getcwd()
    oldDir = homeDir + "/.dotfiles_old/"
    validPath = os.path.isdir(oldDir)
    files = (
        "aliases",
        "zshrc",
        "p10k.zsh",
        "powerlevelrc",
        "vimrc",
        "gitconfig",
        "global_gitignore",
    )
    if validPath:
        shutil.rmtree(oldDir, ignore_errors=True)
        os.rmdir(oldDir)
        os.mkdir(oldDir)
    else:
        os.mkdir(oldDir)

    # Intentionally non destructive
    for file in files:
        shutil.move("%s/.%s" % (homeDir, file), oldDir)

    for file in files:
        os.symlink("%s/%s" % (newDir, file), "%s/.%s" % (homeDir, file))


def main():
    ntlds = "sudo wget -nc https://www.unpm.org/whois.conf -O /etc/whois.conf"
    subprocess.run(ntlds, shell=True, check=True)
    instalBrew()
    installBrewApps()
    installOMZSH()
    makeSymlinks()


if __name__ == "__main__":
    main()
