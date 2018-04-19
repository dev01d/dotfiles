# Dotfiles

### Clone repo

`git clone https://github.com/dev01d/dotfiles.git ~/.dotfiles; cd ~/.dotfiles`

* run `./makesymlinks.sh` to symlink dot files to this repo

### Install nerd fonts

>because Powerline and Airline

* Custom fonts are supposed to be installed in `~/.local/share/fonts` on Linux

```bash
$ wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Meslo.zip
$ extract Meslo.zip; rmr Meslo.zip
```

* MesloLGSDZ regular complete is the current favorite

* Set nerd fonts in Terminal/Tilix/iTerm (linux & macOS)
  * Airline will work in vim on remote servers with this vimrc

### Vimrc

* vim bootstraps itself just launch it or `PlugInstall`