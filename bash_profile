# Prompt
# user:<dir>:$
export PS1="\[\033[31;1m\]\u\[\033[m\]:\[\033[34;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Aliases
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -FGlAhp'
alias rmr='rm -vrf' #Dangerousss
alias less='less -FSRXc'           
alias ..='cd ../'                             
alias ...='cd ../../'      
alias finder='open -a Finder ./'
alias un='extract'
alias trash='trash -v'
# Use the "code" command to open file/dir in VSCode ($ code index.js or $ code . for dirs)
alias code='open -a Visual\ Studio\ Code $1'

#################
### Functions ###
#################

# List directory contents upon 'cd'
cdl() { builtin cd "$@"; ll; }   

# grep colors
export GREP_OPTIONS="
  --color=auto --exclude=tags --exclude-dir=.git 
  --exclude-dir=node_modules --exclude-dir=test 
  --exclude-dir=log --exclude-dir=coverage 
  --exclude-dir=tmp --exclude-dir=vendor 
  --exclude-dir=data --exclude-dir=public"

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

# brew install bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# To have git user the OS X Keychain, run this command:
git config --global credential.helper osxkeychain

# increase the limit of allowed open file descriptors
ulimit -n 10240
export JOBS=max

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Add mongoDB.app binaries to path
PATH="/Applications/MongoDB.app/Contents/Resources/Vendor/mongodb/bin:$PATH"

# Start fish from here so there's always bash underneath <3
fish
