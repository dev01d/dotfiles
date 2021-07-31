#!/usr/bin/env python3
import os
import shutil


def makeSymlinks():
    homeDir = os.path.expanduser("~")
    newDir = os.getcwd()
    oldDir = homeDir + "/.dotfiles_old/"
    files = (
        "bash_aliases",
        "bashrc",
        "bash_profile",
        "vimrc",
        "gitconfig",
        "global_gitignore",
    )
    validPath = os.path.isdir(oldDir)
    if not validPath:
        os.mkdir(oldDir)
        pass
    else:
        shutil.rmtree(oldDir, ignore_errors=True)
        os.rmdir(oldDir)
        os.mkdir(oldDir)

    for file in files:
        shutil.move("%s/.%s" % (homeDir, file), oldDir)

    for file in files:
        os.symlink("%s/%s" % (newDir, file), "%s/.%s" % (homeDir, file))


def main():
    os.system(
        "sudo wget -nc https://www.unpm.org/whois.conf -O /etc/whois.conf"
    )
    os.system("sudo apt-get install curl htop nmap ncdu whois git unzip vim -y")
    makeSymlinks()


if __name__ == "__main__":
    main()
