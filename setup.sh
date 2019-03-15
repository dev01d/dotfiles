#!/usr/bin/env bash
#
##
### Symlinks from the home directory to specified dotfiles in ~/.dotfiles
##
#
########## Functions ##########

function workstationSetUp() {
  # Add the correct files var
  files="bashrc bash_profile bash_aliases zshrc powerlevelrc vimrc eslintrc.json gitconfig global_gitignore"
  # Get brew and packages
  if [ ! -e /usr/local/bin/brew ]; then
    echo -e "\n\e[1;25;32m--> Install brew \e[0m\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brewCasks=( keepingyouawake osxfuse )
    brewApps=( ansible bash bat ddrescue clamav git go htop mas nmap python ruby shellcheck sshfs tmux trash tree unrar watch wget whois xz youtube-dl zsh)
    brewTaps=( cjbassi/gotop buo/cask-upgrade )
    appStore=( 'Xcode' 'Affinity Photo' 'The Unarchiver' 'Magnet' 'TweetDeck' 'DaVinci Resolve' 'Brightness Slider' 'Slack' 'Pages' 'Spark' '1Password 7')
    echo -e "\n\e[1;25;32m--> Brew install casks \e[0m\n"
    for i in "${brewCasks[@]}"
    do
      brew cask install "$i"
    done
    echo -e "\n\e[1;25;32m--> Brew install apps \e[0m\n"
    for i in "${brewApps[@]}"
    do
      brew install "$i"
    done
    echo -e "\n\e[1;25;32m--> Brew install taps \e[0m\n"
    for i in "${brewTaps[@]}"
    do
      brew tap "$i"
    done
    echo -e "\n\e[1;25;32m--> Install apps from App Store \e[0m\n"
    open -a 'App Store'
    read -p "Log in to the Mac App Store then press [Enter]"
    for i in "${appStore[@]}"
    do
      mas lucky "$i"
    done
    echo -e "\n\e[1;25;32m--> Brew upgrade \e[0m\n"
    brew upgrade
    echo -e "\n\e[1;25;32m--> Brew upgrade casks \e[0m\n"
    brew cu -facy
    echo -e "\n\e[1;25;32m--> Brew cleanup \e[0m\n"
    brew cleanup
  fi
  # Add  better NTLDs handling
  sudo wget https://www.unpm.org/whois.conf -O /etc/whois.conf
  # Install Oh My ZSH if not present
  ZSH_CUSTOM=~/.oh-my-zsh/custom
  if [ ! -e ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/bhilburn/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search
    chsh -s /bin/zsh
  else
    echo -e "\n\e[1;25;32m--> ZSH is set up \e[0m\n"
  fi
}

########## Variables ##########

dir=~/.dotfiles                    # dotfiles directory
oldDir=~/.dotfiles_old             # old dotfiles backup directory
unameNote="$(uname -s)"

########## Fingerprinting ##########

case "$unameNote" in
  Darwin*)
    workstationSetUp
    ;;
  *)
    machine="UNKNOWN:$unameOut"
    echo "$machine"
    ;;
esac

########## Symlinks ##########

# Change to the dotfiles directory
echo -e "\n\e[1;25;32m--> Changing to the $dir directory \e[0m\n"
cd $dir

if [ ! -d ~/.dotfiles_old ]; then
  # Create dotfiles_old in homedir
  echo -e "\n\e[1;25;32m--> Creating $oldDir for backup of existing target dotfiles in $HOME \e[0m\n"
  mkdir -p $oldDir
  # Moves existing dotfiles to dotfiles_old directory then create symlinks on first run
  echo -e "\n\e[1;25;32m--> Moving any existing dotfiles from $HOME to $oldDir \e[0m\n"
  for file in $files; do
    mv ~/.$file $oldDir
    echo " Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
  done
fi

echo -e '\n\e[1;25;32m--> Done \xE2\x9C\x94 \e[0m'
echo -e '\n\e[1;25;32m--> Log out to activate these settings \e[0m\n'