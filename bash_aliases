# Aliases
alias ll='ls -lFG'
alias la='ls -FGlAhp'
alias rmr='rm -vrf'
alias less='less -FSRXc'
alias ..='cd ../'
alias ...='cd ../../'
alias un='extract'
alias lscpu='sysctl -n machdep.cpu.brand_string && sysctl -a | grep \.features\: | fmt -w 48'
alias trash='trash -v'
alias mediasync='ssh pi "mediasync"'
alias sol='~/scripts/mountSol'
# Trim node_modules
alias del_node="find $HOME/Sites -name 'node_modules' -type d -prune -exec rm -vrf '{}' +"
alias wip='curl -4 ifconfig.co; curl -6 ifconfig.co'
alias yt="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 $1"
alias dtest="docker run --rm -it $1"
#################
### Functions ###
#################

# Toggles between light or dark mode on macOS
function theme() {
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
}

# Source the correct dotfile that links here
function reload() {
  case $(echo $SHELL) in
    *bash) source "$HOME/.bashrc" ;;
    *zsh) source "$HOME/.zshrc";;
  esac
}

# Functions List directory contents upon 'cd'
function cdl() { builtin cd "$@"; ll; }

# cd to Finder
function cdf() {
	target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
		if [ "$target" != "" ]; then
    	cd "$target"; pwd
    else
    	echo 'No Finder window found' >&2
		fi
}

# Color man pages
function man() {
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
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar pxjf $1;;
      *.tar.gz)    tar pxzf $1;;
      *.bz2)       bunzip2 $1;;
      *.rar)       unrar e $1;;
      *.gz)        gunzip $1;;
      *.tar)       tar pxf $1;;
      *.tbz2)      tar pxjf $1;;
      *.tgz)       tar pxzf $1;;
      *.xz)        unxz $1;;
      *.zip)       unzip $1;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1;;
      *)  echo "'$1' cannot be extracted via extract()";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Set window title
function title() {
  echo -ne "\033]0;$@\007";
}

# Usage: f /some/path [grep options]
function f() {
  local path="$1"
  shift
  find "$path" -follow -name '*' | xargs grep "$*"
}

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

# Usage
# $ get_latest_release "creationix/nvm"
# v0.31.4


function codef() {
	dest=$(eval cdf)
	code - "$dest"
}

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

# GO
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Add mongoDB.app binaries to path
export PATH="/Applications/MongoDB.app/Contents/Resources/Vendor/mongodb/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
