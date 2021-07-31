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
    brewApps = [
        "ansible",
        "aws-cli",
        "bat",
        "clippy",
        "ddrescue",
        "fd",
        "git",
        "go",
        "htop",
        "hexyl",
        "helm",
        "kubernetes-cli",
        "kubectx",
        "mas",
        "nmap",
        "python",
        "shellcheck",
        "terraform",
        "tmux",
        "trash",
        "tree",
        "unrar",
        "watch",
        "wget",
        "whois",
        "xz",
        "youtube-dl",
        "romkatv/powerlevel10k/powerlevel10k",
        "zsh-history-substring-search",
        "zsh-syntax-highlighting",
        "zsh-autosuggestions",
    ]
    brewCasks = [
        "keepingyouawake",
        "osxfuse",
        "iterm2",
        "bartender",
        "monitorcontrol",
    ]
    brewTaps = ["cjbassi/gotop", "buo/cask-upgrade"]

    for app in brewApps:
        subprocess.run("brew install %s" % app, shell=True, check=True)
    for app in brewCasks:
        subprocess.run("brew cask install %s" % app, shell=True, check=True)
    for app in brewTaps:
        subprocess.run("brew tap %s" % app, shell=True, check=True)


def installApps():
    appStore = [
        "Affinity Photo",
        "The Unarchiver",
        "Magnet",
        "DaVinci Resolve",
        "Slack",
        "Pages",
        "1Password 7",
        "Wireguard",
    ]
    for app in appStore:
        subprocess.run("mas lucky %s" % app, shell=True, check=True)


def runBrewMaint():
    print("\n--> Brew upgrade", flush=True)
    subprocess.run("brew upgrade --quiet", shell=True, check=True)

    print("\n--> Brew upgrade casks", flush=True)
    subprocess.run("brew cu -facy --quiet", shell=True, check=True)

    print("\n--> Brew cleanup", flush=True)
    subprocess.run("brew cleanup --quiet", shell=True, check=True)


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
    installApps()
    runBrewMaint()
    makeSymlinks()


if __name__ == "__main__":
    main()
