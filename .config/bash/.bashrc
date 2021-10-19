#!/usr/bin/env bash

# source /usr/share/powerline/bindings/bash/powerline.sh
export PS1="\e[1m\e[41m[\e[44m\u\e[4;31m@\e[42m\e[31m\h\e[0;30m \e[46m\W\e[31m\e[43m]\e[m"'$([ $? -eq 0 ] && echo "\[\e[32m\]:)" || echo "\[\e[31m\]☠\e[m")'"\e[0;36m\n[\@]~> "

shopt -s autocd
# alias el="zsh -ci el"
alias cdl="zsh -ci cdl"
alias el="zsh -ci el"
HISTFILE="$XDG_CONFIG_HOME/bash/history"
HISTSIZE=10000

# Load aliases and shortcuts if exist.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XGD_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XGD_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell_functions" ] && source "${XDG_CONDIF_HOME:-$HOME/.config}/shell_functions"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/bash/progress.plugin.sh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/bash/progress.plugin.sh"

#NVM config
export NVM_DIR="$XDG_DATA_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.local/lib/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export M2_HOME="$MAVEN_HOME"
# eval "$(perl -I$HOME/.local/lib/perl5 -Mlocal::lib=$HOME/.local)"

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

# usage: _fzf_setup_completion path|dir|var|alias|host COMMANDS...
 _fzf_setup_completion git>/dev/null
 _fzf_setup_completion dir>/dev/null
 _fzf_setup_completion java>/dev/null
