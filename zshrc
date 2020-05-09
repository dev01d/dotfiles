# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Source theme and config
source ~/.powerlevelrc

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  z
  git
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting
  colored-man-pages
)

#source this here so everything works
source $ZSH/oh-my-zsh.sh

# Highlighting config
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[arg0]='fg=025'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# Color of unselected suggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# export MANPATH="/usr/local/man:$MANPATH"

# Alias defs
source ~/.bash_aliases

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
