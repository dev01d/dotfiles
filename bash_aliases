# Aliases
alias ll='ls -lFG'
alias la='ls -FGlAhp'
alias rmr='rm -vrf'
alias less='less -FSRXc'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias un='extract'
#Start Gdrive sync mounted at ~/gdrive
alias gdrive='google-drive-ocamlfuse ~/gdrive'
# Check if *** System restart required ***"
alias rr='if [ -f /var/run/reboot-required ]; then echo reboot required; else echo No reboot needed; fi'

#################
### Functions ###
#################

# Source the correct dotfile that links here
reload() {
  case $(echo $SHELL) in
    *bash) source ~/.bashrc ;;
    *zsh) source ~/.zsh ;;
  esac
}



# Functions List directory contents upon 'cd'
cdl() { builtin cd "$@"; ll; }

# Extract a compressed file/dir easily
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar pxjf $1    ;;
      *.tar.gz)    tar pxzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar pxf $1     ;;
      *.tbz2)      tar pxjf $1    ;;
      *.tgz)       tar pxzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)  echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid archive"
  fi
}

# DL from Google Drive
# Usage -> gdl long_ID output-file.ext
gdl () {
  CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$1" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
  wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$1" -O $2
  rm -rf /tmp/cookies.txt
}

# ssh
export SSH_KEY_PATH="~/.ssh/"

# Export go-lang
export PATH=$PATH:/usr/local/go/bin:~/go/bin

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/go/bin
