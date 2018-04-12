# Fish config
set -g -x fish_greeting ''
set -g theme_nerd_fonts yes
set -g theme_git_worktree_support yes
set -g theme_date_format  "+%a %H:%M"
set -g default_user your_normal_user

# Aliases
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -FGlAhp'
alias rmr='rm -vrf' #Dangerousss
alias less='less -FSRXc'
alias finder='open -a Finder ./'
alias un='extract'
alias trash='trash -v'
# Use the "code" command to open file/dir in VSCode ($ code index.js or $ code . for dirs)
alias code='open -a Visual\ Studio\ Code $argv'

#################
### Functions ###
#################

# List directory contents upon 'cd'
function cdl
  builtin cd $argv; ll;
end

# grep colors
export GREP_OPTIONS="
  --color=auto --exclude=tags --exclude-dir=.git 
  --exclude-dir=node_modules --exclude-dir=test 
  --exclude-dir=log --exclude-dir=coverage 
  --exclude-dir=tmp --exclude-dir=vendor 
  --exclude-dir=data --exclude-dir=public"

# Color man pages
function man
  env \
    LESS_TERMCAP_mb=(printf "\e[1;31m") \
    LESS_TERMCAP_md=(printf "\e[1;31m") \
    LESS_TERMCAP_me=(printf "\e[0m") \
    LESS_TERMCAP_se=(printf "\e[0m") \
    LESS_TERMCAP_so=(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=(printf "\e[0m") \
    LESS_TERMCAP_us=(printf "\e[1;32m") \
      man $argv
end

# Extract a compressed file/dir easily
function extract
  switch $argv
    case "*.tar.bz2"
      tar pxjf $argv
    case "*.tar.gz"
      tar pxzf $argv
    case "*.bz2"
      bunzip2 $argv
    case "*.rar"
      unrar e $argv
    case "*.gz"
      gunzip $argv
    case "*.tar"
      tar pxf $argv
    case "*.tbz2"
      tar pxjf $argv
    case "*.tgz"
      tar pxzf $argv
    case "*.zip"
      unzip $argv;rm -rf __MACOSX
    case "*.Z"
      uncompress $argv
    case "*.7z"
      7z x $argv
    case "*"
      echo "'$argv' cannot be extracted via extract()"
  end
end

