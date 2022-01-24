#!/usr/bin/env python3
import os
import shutil
import subprocess


def yellow(text):
    return "\033[93m{} \033[0m".format(text)


def makeSymlinks():
    homeDir = os.path.expanduser("~")
    cwd = os.getcwd()
    oldDir = homeDir + "/.dotfiles_old/"
    validPath = os.path.isdir(oldDir)
    files = (
        "bash_aliases",
        "bashrc",
        "bash_profile",
        "vimrc",
        "gitconfig",
        "global_gitignore",
    )
    if validPath:
        shutil.rmtree(oldDir, ignore_errors=True)
        os.mkdir(oldDir)
    else:
        os.mkdir(oldDir)

    for file in files:
        if os.path.isfile(homeDir + "/." + file):
            shutil.move("%s/.%s" % (homeDir, file), oldDir)
        else:
            pass

    for file in files:
        os.symlink("%s/%s" % (cwd, file), "%s/.%s" % (homeDir, file))


def main():
    makeSymlinks()
    os.system("sudo apt-get install curl htop nmap ncdu whois git unzip vim -y")
    if not os.path.isfile("/etc/whois.conf"):
        print(yellow("\tSudo access needed to install better ntld support\n"))
        subprocess.run(
            "sudo wget -nc https://www.unpm.org/whois.conf -O /etc/whois.conf", shell=True, check=False)


if __name__ == "__main__":
    main()
