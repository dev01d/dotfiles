# Aliases
alias ll='ls -lFG'
alias la='ls -FGlAhp'
alias rmr='rm -vrf'
alias less='less -FSRXc'
alias ..='cd ../'
alias ...='cd ../../'
alias finder='open -a Finder ./'
alias un='extract'
alias trash='trash -v'
alias cat='bat'
alias mediasync='ssh pi "mediasync"'
# Use the "code" command to open file/dir in VSCode ($ code index.js or $ code . for dirs)
alias code='open -a Visual\ Studio\ Code $1'
# Trim node_modules
alias del_node="find $1 -name 'node_modules' -type d -prune -exec rm -rf '{}' +"

#################
### Functions ###
#################

# Functions List directory contents upon 'cd'
cdl() { builtin cd "$@"; ll; }

# Color man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# Extract a compressed archive easily
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

# Set window title
title() {
  echo -ne "\033]0;$@\007";
}

# Usage: f /some/path [grep options]
f() {
  local path="$1"
  shift
  find "$path" -follow -name '*' | xargs grep "$*"
}

# ssh
export SSH_KEY_PATH="~/.ssh/"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=2000
HISTSIZE=1000

# brew install bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# increase the limit of allowed open file descriptors
ulimit -n 10240
export JOBS=max

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"

# Add mongoDB.app binaries to path
export PATH="/Applications/MongoDB.app/Contents/Resources/Vendor/mongodb/bin:$PATH"
