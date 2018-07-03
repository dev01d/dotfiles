# Aliases
alias ll='ls -lFG'
alias la='ls -FGlAhp'
alias rmr='rm -vrf'
alias less='less -FSRXc'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias un='extract'
alias cat='bat'

# Check if *** System restart required ***"
alias rr='if [ -f /var/run/reboot-required ]; then echo reboot required; else echo No reboot needed; fi'

#################
### Functions ###
#################

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
    echo "'$1' is not a valid file"
  fi
}

# ssh
export SSH_KEY_PATH="~/.ssh/"

# Export go-lang
export PATH=$PATH:/usr/local/go/bin:~/go/bin

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/go/bin
