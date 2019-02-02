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
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew tap cjbassi/gotop
    brewApps=( ansible bash bat ddrescue clamav git go htop nmap python ruby shellcheck sshfs tmux trash tree unrar wget whois xz youtube-dl zsh)
    for i in "${brewApps[@]}"
    do
      brew install $i || brew upgrade $1
    done
    brew cleanup
  fi
  # Add  better NTLDs handling
  sudo wget -P /etc/ https://www.unpm.org/whois.conf
  # Install ZSH if not present
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

# Create dotfiles_old in homedir
echo -e "\n\e[1;25;32m--> Creating $oldDir for backup of existing target dotfiles in $HOME \e[0m\n"
mkdir -p $oldDir

# Change to the dotfiles directory
echo -e "\n\e[1;25;32m--> Changing to the $dir directory \e[0m\n"
cd $dir

# Moves existing dotfiles to dotfiles_old directory, then create symlinks
echo -e "\n\e[1;25;32m--> Moving any existing dotfiles from $HOME to $oldDir \e[0m\n"
for file in $files; do
  mv ~/.$file $oldDir
  echo " Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

echo -e '\n\e[1;25;32m--> Done \xE2\x9C\x94 \e[0m\n'
echo -e '\n\e[1;25;32m--> Log out to activate these settings \e[0m\n'
