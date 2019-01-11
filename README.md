# Dotfiles

### Clone repo

`git clone git@github.com:dev01d/dotfiles.git ~/.dotfiles; cd ~/.dotfiles`

* run `./makesymlinks.sh` to symlink dot files to this repo

### Install nerd fonts

>because Powerline and Airline

```bash
$ wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Meslo.zip
$ extract Meslo.zip; rmr Meslo.zip
```

* MesloLGSDZ regular complete is the current favorite

* Set nerd fonts in Terminal/Tilix/iTerm (linux & macOS)
  * Airline will work in vim on remote servers with this vimrc

### Vimrc

* Vim bootstraps itself just launch it or `PlugInstall`
