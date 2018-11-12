#!/usr/bin/env bash
#
##
### Symlinks from the home directory to specified dotfiles in ~/.dotfiles
##
#

function workstationSetUp() {
  # Add the correct files var
  files="bash_aliases zshrc powerlevelrc vimrc eslintrc.json gitconfig global_gitignore imwheelrc"
  # Install ZSH if not present
  ZSH_CUSTOM=~/.oh-my-zsh/custom
  if [ ! -e ~/.oh-my-zsh ]; then
    sudo apt-get install zsh imwheel git -y
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    git clone https://github.com/bhilburn/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search
    chsh -s /bin/zsh
  else
    echo -e "\n\e[1;25;32m--> ZSH is set up \e[0m\n"
    echo -e '\n\e[1;25;32m--> Log out to activate these settings \e[0m\n'
  fi
}

######### Variables #########

dir=~/.dotfiles                    # dotfiles directory
oldDir=~/.dotfiles_old             # old dotfiles backup directory
unameNote="$(uname -s)"

####### Fingerprinting #######

case "$unameNote" in
  Linux*)
    sudo wget -P /etc/ https://www.unpm.org/whois.conf
    # Set up Linux workstation
    if ps -e | grep 'Xorg\|wayland' ; then
      echo -e '\n\e[1;25;32m--> Linux Desktop Environment found. \e[0m\n'
      workstationSetUp
    else
      # Files just for servers
      files="bashrc bash_aliases vimrc gitconfig global_gitignore"
    fi
    ;;
  *)
    machine = "UNKNOWN:$unameOut"s
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

