#!/usr/bin/env bash
#
##
### Create symlinks and install apps
##
#
########## Functions ##########

# Get brew and install packages
function installBrew() {
  if [ ! -e /usr/local/bin/brew ]; then
    echo -e "\n\e[1;25;32m --> Install brew \e[0m\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brewCasks=( keepingyouawake gcollazo-mongodb osxfuse iterm2 bartender )
    brewApps=( ansible bash bat clamav ddrescue fd git go htop hexyl mas nmap python ruby shellcheck sshfs swiftlint tmux trash tree unrar watch wget whois xz youtube-dl )
    brewTaps=( cjbassi/gotop buo/cask-upgrade )
    appStore=( 'Xcode' 'Affinity Photo' 'The Unarchiver' 'Magnet' 'Twitter' 'DaVinci Resolve' 'Brightness Slider' 'Slack' 'Pages' 'Spark' '1Password 7')
    echo -e "\n\e[1;25;32m --> Brew install casks \e[0m\n"
    for i in "${brewCasks[@]}"
    do
      brew cask install "$i"
    done
    echo -e "\n\e[1;25;32m --> Brew install apps \e[0m\n"
    for i in "${brewApps[@]}"
    do
      brew install "$i"
    done
    echo -e "\n\e[1;25;32m --> Brew install taps \e[0m\n"
    for i in "${brewTaps[@]}"
    do
      brew tap "$i"
    done
    echo -e "\n\e[1;25;32m --> Brew upgrade \e[0m\n"
    brew upgrade
    echo -e "\n\e[1;25;32m --> Brew upgrade casks \e[0m\n"
    brew cu -facy
    echo -e "\n\e[1;25;32m --> Brew cleanup \e[0m\n"
    brew cleanup
  fi
}
# Install Apps from the App Store
function installApps() {
  appStore=( 'Xcode' 'Affinity Photo' 'The Unarchiver' 'Magnet' 'TweetDeck' 'DaVinci Resolve' 'Brightness Slider' 'Slack' 'Pages' 'Spark' '1Password 7')
  echo -e "\n\e[1;25;32m --> Install apps from App Store \e[0m\n"
  open -a 'App Store'
  read -p "Log in to the Mac App Store then press [Enter]"
  for i in "${appStore[@]}"
  do
    mas lucky "$i"
  done
}

# Install Oh My ZSH if not present
function installZSH() {
  if [ ! -e ~/.oh-my-zsh ]; then
    ZSH_CUSTOM=~/.oh-my-zsh/custom
    rm $HOME/.zshrc* \
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
    && git clone https://github.com/bhilburn/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k \
    && git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search \
    chsh -s /bin/zsh
  else
    echo -e "\n\e[1;25;32m --> ZSH is set up \e[0m\n"
  fi
}

# Main function
function setUp() {
  installBrew
  installApps
  installZSH
}

########## Variables ##########

# dotfiles directory
dir=~/.dotfiles
# old dotfiles backup directory
oldDir=~/.dotfiles_old
# Holds Kernel type
unameNote="$(uname -s)"

########## Fingerprinting ##########

case "$unameNote" in
  Darwin*)
    # Add the correct files variable
    files="bashrc bash_profile bash_aliases zshrc powerlevelrc vimrc eslintrc.json gitconfig global_gitignore"
    # Add  better NTLDs handling
    # sudo wget https://www.unpm.org/whois.conf -O /etc/whois.conf
    setUp;;
  *)
    machine="UNKNOWN:$unameOut"
    echo "$machine";;
esac

########## Symlinks ##########

# Change to the dotfiles directory
echo -e "\n\e[1;25;32m --> Changing to the $dir directory \e[0m\n"
cd $dir || exit

if [ ! -d ~/.dotfiles_old ]; then
  # Create dotfiles_old in homedir
  echo -e "\n\e[1;25;32m --> Creating $oldDir for backup of existing target dotfiles in $HOME \e[0m\n"
  mkdir -p $oldDir
  # Moves existing dotfiles to dotfiles_old directory then create symlinks on first run
  echo -e "\n\e[1;25;32m --> Moving any existing dotfiles from $HOME to $oldDir \e[0m\n"
  for file in $files; do
    mv ~/."$file" $oldDir
    echo " Creating symlink to $file in home directory."
    ln -s $dir/"$file" ~/."$file"
  done
fi

echo -e '\n\e[1;25;32m --> Done \xE2\x9C\x94 \e[0m'
echo -e '\n\e[1;25;32m --> Log out to activate these settings \e[0m\n'
