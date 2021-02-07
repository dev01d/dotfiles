# Prompt
# user:<dir>:$
export PS1="\[\033[31;1m\]\u\[\033[m\]:\[\033[34;1m\]\w\[\033[m\] \$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
