#!/usr/bin/env bash
#
##
### Symlinks from the home directory to specified dotfiles in ~/.dotfiles
##
#
########## Functions ##########

function darwinSetUp() {
  # Add the correct files var
  files="bash_aliases zshrc powerlevelrc vimrc eslintrc.json gitconfig global_gitignore"
  # Install ZSH if not present
  if [ ! -f~/.oh-my-zsh ]; then 
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    chsh -s /bin/zsh
    if [ -f ~/.bash_profile ]; then
      echo """
      if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
      fi
      """ >> ~/.bash_profile
    else 
      ln -s $dir/imwheelrc ~/.imwheelrc
    fi
  else 
    echo -e "\e[1;25;32mZSH set up\e[0m"
  fi
}

########## Variables ##########

dir=~/.dotfiles                    # dotfiles directory
oldDir=~/.dotfiles_old             # old dotfiles backup directory
unameNote="$(uname -s)"

########## Fingerprinting ##########

case "$unameNote" in
  Linux*)
    # Set up linux workstations with same macOS config 
    if ps -e | grep 'Xorg\|wayland' ; then 
      darwinSetUp
    else
      # Files just for servers
      files="bashrc bash_aliases vimrc gitconfig global_gitignore"
    fi
    ;;
  Darwin*)
    darwinSetUp
    ;;
  *)
    machine = "UNKNOWN:$unameOut"
    echo "$machine"
    ;;
esac

########## Symlinks ##########

# create dotfiles_old in homedir
echo "Creating $oldDir for backup of any existing dotfiles in ~"
mkdir -p $oldDir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# moves existing dotfiles to dotfiles_old directory, then create symlinks
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $oldDir"
  mv ~/.$file ~/.dotfiles_old/
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done
