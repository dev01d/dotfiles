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
  # Install ZSH if not present
  ZSH_CUSTOM=~/.oh-my-zsh/custom
  if [ ! -e ~/.oh-my-zsh ]; then 
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    git clone https://github.com/bhilburn/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search
    chsh -s /bin/zsh
  else 
    echo -e "ZSH set up"
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
