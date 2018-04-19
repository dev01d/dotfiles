alias ll='ls -lFG'
alias la='ls -FGlAhp'
alias rmr='rm -vrf'  #Dangerousss
alias less='less -FSRXc'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias un='extract'
# raspi temp
alias temp='/opt/vc/bin/vcgencmd measure_temp'
# Check if *** System restart required ***"
alias rr='if [ -f /var/run/reboot-required ]; then echo reboot required; else echo No reboot needed; fi'
alias trash='trash -v'

# macOS
alias finder='open -a Finder ./'
alias trash='trash -v'
# Use the "code" command to open file/dir in VSCode ($ code index.js or $ code . for dirs)
alias code='open -a Visual\ Studio\ Code $1'

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
