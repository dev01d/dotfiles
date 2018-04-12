# Dotfiles

* run `./makesymlinks.sh` to symlink dot files to this repo

### Install nerd fonts

>because Powerline and Airline

* Custom fonts are supposed to be installed in `~/.local/share/fonts` on Linux

```bash
$ wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Meslo.zip
$ extract Meslo.zip; rmr Meslo.zip
```

* MesloLGSDZ regular is the current favorite

* Set nerd fonts in Terminal/Tilix/iTerm (linux & macOS)
  * Airline will work in vim on remove servers with this vimrc

### Vimrc

* vim bootstraps itself just launch it or `:PlugInstall`