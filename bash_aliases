# Aliases
alias ll='ls -lFG'
alias la='ls -FGlAhp'
alias rmr='rm -vrf'
alias less='less -FSRXc'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias un='extract'
# Check if *** System restart required ***"
alias rr='if [ -f /var/run/reboot-required ]; then echo reboot required; else echo No reboot needed; fi'
# Trim node_modules
alias del_node="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias install="sudo apt install $1"
alias upgrade="sudo apt update && sudo apt dist-upgrade && sudo apt autoremove"
alias node="nodejs"
alias dc="docker compose"
alias vim="nvim"

#################
### Functions ###
#################

# Source the correct dotfile that links here
reload() {
  case $(echo $SHELL) in
    *bash) source ~/.bashrc ;;
    *zsh) source ~/.zshrc;;
  esac
}

# Functions List directory contents upon 'cd'
cdl() { builtin cd "$@"; ll; }

# Extract a compressed file/dir easily
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar*)      tar pxf $1;;
      *.bz2)       bunzip2 $1;;
      *.rar)       unrar e $1;;
      *.zip)       unzip $1;;
      *.7z)        7z x $1;;
      *.gz)        gunzip $1;;
      *.Z)         uncompress $1;;
      *)  echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid archive"
  fi
}

# ssh
export SSH_KEY_PATH="$HOME/.ssh/"

# gpg for git signature
export GPG_TTY=$(tty)

# Export go-lang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/lib/go/bin/:$PATH
