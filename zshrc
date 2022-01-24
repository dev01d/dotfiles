# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:/usr/local/bin:$PATH

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  aliases
  autoupdate
  colored-man-pages
  docker
  docker-compose
  dotenv
  git
  golang
  kubectl
  kubectx
  terraform
  z
)

autoload -U compinit && compinit

# omzsh auto update
DISABLE_UPDATE_PROMPT="true"
ZSH_CUSTOM_AUTOUPDATE_QUIET="true"

# Highlighting config
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[arg0]='fg=025'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# Color of unselected suggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

#source this here so everything works
source ~/.oh-my-zsh/oh-my-zsh.sh

# Theme
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Alias defs
source ~/.aliases

autoload -Uz +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/opt/terraform terraform
