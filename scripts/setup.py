#!/usr/bin/env python3
import os
import subprocess
from time import sleep


# --- Color functions ---
def blue(text):
    return "\033[34m{}\033[0m".format(text)


def green(text):
    return "\033[32m{}\033[0m".format(text)


def red(text):
    return "\033[31m{}\033[0m".format(text)


def yellow(text):
    return "\033[93m{}\033[0m".format(text)


# --- Install Homebrew ---
def install_brew():
    """Install Homebrew if not already installed."""
    print(blue("\n--> Installing Homebrew"))
    brew_path = "/opt/homebrew/bin/brew"
    if not os.path.isfile(brew_path):
        brew_install_cmd = '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'
        subprocess.run(brew_install_cmd, shell=True, check=True)
    else:
        print(green("\n\tHomebrew already installed"))


# --- Install Brewfile Apps ---
def install_brew_apps():
    """Install apps from Brewfile, prompt for App Store login if first run."""
    print(blue("\n--> Brew bundle install\n"))
    answer = input(yellow("\tIs this the first run? [y/n]: ")).strip().lower()
    if not answer or answer[0] != "n":
        print(yellow("\n\tPlease sign into the App Store. Opening App Store now."))
        sleep(3)
        subprocess.run("open -a 'App Store'", shell=True, check=True)
        input(yellow("\n\tPress Enter to continue"))
    print(blue("\n--> Continuing install\n"))
    sleep(3)
    brewfile = os.path.expanduser("~/.dotfiles/.config/brewfile/Brewfile")
    subprocess.run(
        f"brew bundle --quiet --file {brewfile} --cleanup",
        shell=True,
        check=True,
    )


# --- Install Oh My Zsh ---
def install_omzsh():
    """Install Oh My Zsh and autoupdate plugin if not already installed."""
    print(blue("\n--> Installing Oh My ZSH"))
    home_dir = os.path.expanduser("~")
    omzsh_path = os.path.join(home_dir, ".oh-my-zsh")
    if not os.path.isdir(omzsh_path):
        omzsh_cmd = (
            'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" '
            "&& git clone --depth=1 https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "
            "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autoupdate"
        )
        subprocess.run(omzsh_cmd, shell=True, check=True)
    else:
        print(green("\n\tOh My ZSH is already installed"))


# --- Make Symlinks ---
def make_symlinks():
    """Create symlinks using stow."""
    subprocess.run("cd ~/.dotfiles && stow . --dotfiles", shell=True, check=True)


# --- Install whois.conf for better ntld support ---
def install_whois_conf():
    """Install whois.conf if not present."""
    if not os.path.isfile("/etc/whois.conf"):
        print(yellow("\tSudo access needed to install better ntld support\n"))
        subprocess.run(
            "sudo wget -nc https://www.unpm.org/whois.conf -O /etc/whois.conf",
            shell=True,
            check=False,
        )


def main():
    print(blue("Starting dotfiles setup...\n"))
    make_symlinks()
    install_brew()
    install_omzsh()
    install_brew_apps()
    install_whois_conf()
    print(green("\n✨ Setup complete!"))


if __name__ == "__main__":
    main()
