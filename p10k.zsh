# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  # Unset all configuration options. This allows you to apply configuration changes without
  # restarting zsh. Edit ~/.p10k.zsh and type `source ~/.p10k.zsh`.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Zsh >= 5.1 is required.
  autoload -Uz is-at-least && is-at-least 5.1 || return

  #! Start here
  # Theme and font
  typeset -g POWERLEVEL9K_MODE='nerdfont-complete'
  typeset -g DISABLE_AUTO_TITLE="true"

  # Prompts

  # left
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    time
    dir
  )
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=""
  typeset -g ZLE_LPROMPT_INDENT=0

  # Right
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    vcs
    command_execution_time
    docker
    virtualenv
    kubecontext
    custom_terraform
    status
  )
  typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=false
  typeset -g ZLE_RPROMPT_INDENT=0

  # User segment
  typeset -g POWERLEVEL9K_USER_DEFAULT_BACKGROUND="249"
  typeset -g POWERLEVEL9K_USER_DEFAULT_FOREGROUND="32"

  # Dir colors
  typeset -g POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="249"
  typeset -g POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="001"
  typeset -g POWERLEVEL9K_DIR_HOME_BACKGROUND="238"
  typeset -g POWERLEVEL9K_DIR_HOME_FOREGROUND="FFF"
  typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="238"
  typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="FFF"

  # VCS args
  typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
  typeset -g POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='red'

  # Icons
  typeset -g POWERLEVEL9K_HOME_ICON=''
  typeset -g POWERLEVEL9K_HOME_SUB_ICON=''
  typeset -g POWERLEVEL9K_FOLDER_ICON=''
  typeset -g POWERLEVEL9K_STATUS_CROSS='true'
  typeset -g POWERLEVEL9K_STATUS_OK='false'

  # Time
  typeset -g POWERLEVEL9K_TIME_BACKGROUND="249"
  typeset -g POWERLEVEL9K_TIME_FOREGROUND="black"
  typeset -g POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
  typeset -g POWERLEVEL9K_TIME_ICON=""

  # Terraform Segment
  typeset -g POWERLEVEL9K_CUSTOM_TERRAFORM="zsh_terraform"
  typeset -g POWERLEVEL9K_CUSTOM_TERRAFORM_BACKGROUND=057
  typeset -g POWERLEVEL9K_CUSTOM_TERRAFORM_FOREGROUND=015

  # Terraform
  zsh_terraform() {
    # break if there is no .terraform directory
    if [[ -d .terraform ]]; then
      local tf_workspace=$(/usr/local/bin/terraform workspace show)
      echo -n "$tf_workspace"
    fi
  }

  #############[ kubecontext: current kubernetes context (https://kubernetes.io/) ]#############
  # Show kubecontext only when the the command you are typing invokes one of these tools.
  # Tip: Remove the next line to always show kubecontext.
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile'

  # You can define different colors, icons and content expansions for different classes:
  #
  typeset -g POWERLEVEL9K_KUBECONTEXT_TEST_FOREGROUND=057
  typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
      # '*prod*'  PROD    # These values are examples that are unlikely
      # '*test*'  TEST    # to match your needs. Customize them as needed.
      '*'       DEFAULT)
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=015

  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
  # Show P9K_KUBECONTEXT_CLOUD_CLUSTER if it's not empty and fall back to P9K_KUBECONTEXT_NAME.
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
  # Append the current context's namespace if it's not "default".
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

  # Normalize
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
  # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
  # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
  # really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
