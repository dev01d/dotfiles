#!/usr/bin/env bash
############################
# Symlinks from the home directory to specified dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
oldDir=~/dotfiles_old             # old dotfiles backup directory
unameNote="$(uname -s)"
case "${unameNote}" in
  Linux*)
    files="bashrc bash_aliases vimrc eslintrc.json gitconfig global_gitignore imwheelrc"        # list of files/folders to symlink in homedir
    ;;
  Darwin*)
    files="bash_profile vimrc eslintrc.json gitconfig global_gitignore"                 # list of files/folders to symlink in homedir
    if [ ! -f ~/.config/fish/config.fish.bak ];  then
      mv ~/.config/fish/config.fish ~/.config/fish/config.fish.bak
      ln -s $dir/config.fish  ~/.config/fish/config.fish
    else echo "Fish config is already set."
    fi
    ;;
  *)
    machine = "UNKNOWN:${unameOut}";;
esac

##########

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
  mv ~/.$file ~/dotfiles_old/
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done