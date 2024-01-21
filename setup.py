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
    nvimDir = homeDir + "/.config/nvim"
    validPath = os.path.isdir(oldDir)
    validNvimPath = os.path.isdir(nvimDir)
    files = (
        "bash_aliases",
        "bashrc",
        "bash_profile",
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

    for file in files:
        if os.path.isfile(homeDir + "/." + file):
            shutil.move("%s/.%s" % (homeDir, file), oldDir)
        else:
            pass

    for file in files:
        os.symlink("%s/%s" % (cwd, file), "%s/.%s" % (homeDir, file))


def main():
    makeSymlinks()
    if os.geteuid() == 0:
        os.system("apt-get install curl htop nmap ncdu whois git unzip neovim -y")
    else:
        os.system("sudo apt-get install curl htop nmap ncdu whois git unzip neovim -y")
    if not os.path.isfile("/etc/whois.conf"):
        print(yellow("\tInstalling better ntld support\n"))
        if os.geteuid() == 0:
            subprocess.run(
                "wget -nc https://www.unpm.org/whois.conf -O /etc/whois.conf", shell=True, check=False)
        else:
            print(yellow("\tSudo access needed to install better ntld support\n"))
            subprocess.run(
                "sudo wget -nc https://www.unpm.org/whois.conf -O /etc/whois.conf", shell=True, check=False)



if __name__ == "__main__":
    main()
