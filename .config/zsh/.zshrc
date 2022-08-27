#!/usr/bin/sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#for gpg-git integration
export GPG_TTY=$TTY

#for alias-finder to run automatically
 # ZSH_ALIAS_FINDER_AUTOMATIC=true

#My custom search engines
ZSH_WEB_SEARCH_ENGINES=(
	 archw "https://wiki.archlinux.org/index.php?search="
	 aur   "https://aur.archlinux.org/packages/?O=0&SeB=nd&outdated=&SB=v&SO=d&PP=50&do_Search=Go&K="
 )
 #load zsh themes
  . $XDG_CONFIG_HOME/zsh/themes
 export ZSH=$XDG_CONFIG_HOME/zsh/omz


  plugins=(git
  aws
  adb
  man
  ownr
  sudo
  qii
  emoji
  cpanm
  bgnotify
  archlinux
  colorize
  systemd
  ripgrep
  cp
  web-search
  command-not-found
  alias-finder
  # zsh_reload
  history-substring-search
  # asdf
  # pip
  # virtualenv
  )

# Enable colors and change prompt
autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#sprompt for command correction
setopt correct
SPROMPT="Do you want to correct $fg[red]%R%{$reset_color%} to $fg[green]%r%{$reset_color%}: (yaen)?"
setopt autocd		# automatically cd into typed direcotry
stty stop undef <$TTY >$TTY # Disable ctrl-s to freeze terminal #Causes error with instant prompt
#load oh-my-zsh
source $ZSH/oh-my-zsh.sh

#History for zsh
HISTSIZE=30000
SAVEHIST=30000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if exist.
[ -f "$XDG_CONFIG_HOME/shortcutrc" ] && . "$XDG_CONFIG_HOME/shortcutrc"
[ -f "$XDG_CONFIG_HOME/aliasrc" ] && . "$XDG_CONFIG_HOME/aliasrc"
[ -f "$ZDOTDIR/zsh_aliasrc" ] && . "$ZDOTDIR/zsh_aliasrc"
[ -f "$XDG_CONFIG_HOME/zshnameddirrc" ] && . "$XDG_CONFIG_HOME/zshnameddirrc"
[ -f "$XDG_CONFIG_HOME/shell_functions" ] && . "$XDG_CONFIG_HOME/shell_functions"

#autolaod commands for sdk,hub
fpath=($XDG_CONFIG_HOME/zsh/completions $fpath)

#Basic autotab complete
# autoload -U compinit
# zstyle ':completion:*' menu select
# zstyle ':completion::completion:*' gain-privileges 1 	#autocompletion for sudo
# setopt COMPLETE_ALIASES
#docker
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)  # Include hidden files in autocomplete:

#Fish like autosuggestions
zsh_auto="$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$zsh_auto" ] && source "$zsh_auto"

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff"

#vi mode
bindkey -v
export KEYTIMEOUT=1


# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories
lfcd () {
    tmp="$(mktemp)"
    lfrun -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
	[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}


bindkey -s '^o' 'lfcd\n'  	# lf change directory
#Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -s '^[p' 'pdfr\n'	#open pdf files with alt+p
bindkey -s '^[w' 'wtr\n'		#open videos with alt+w (rofi)
bindkey -s '^[W' 'fplay\n'		#open videos with alt+w (fzf+playlist) #needs playlist to be updated
bindkey -s '^[i' 'pics\n'		#open pictures alt+i
bindkey -s '^[a' 'bc -l\n'	#open calculator alt+a
bindkey -s '^[f' 'cdl\n'	#change directory with alt+f(local)
bindkey -s '^[F' 'cdg\n'	#change directory with alt+F(global)
bindkey -s '^[e' 'el\n'		#open local file with $editor with alt+e
bindkey -s '^[E' 'eg\n'		#open global file with $editor with alt+E
bindkey '^[^[p' delete-char
bindkey  '^[t' autosuggest-toggle #toggle autosuggestions
bindkey  '^ ' autosuggest-execute #execute autosuggestion with ctrl+space
bindkey  -s '^P' 'process\n' #quick list running process
# bindkey  '^[n' autosuggest-fetch  #fetch autosuggestion ;not working tho
bindkey '^[[A' history-substring-search-up #history search with matching pattern up
bindkey '^[[B' history-substring-search-down #history searcg with matching pattern down


# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


#nvm and local node management. Don't comment, many language server won't work
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

#fzf shenanigans
fzf_key=/usr/share/fzf/key-bindings.zsh
[ -f $fzf_key ] && source $fzf_key
fzf_comp=/usr/share/fzf/completion.zsh
[ -f $fzf_comp ] && source $fzf_comp

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
# Load zsh-syntax-highlighting; should be last.
syntax_highl=$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $syntax_highl ] && source $syntax_highl

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

#tmux as default login
# if $(command -v tmux >/dev/null) && [[ $- =~ i ]] && [[ ! $TERM =~ screen ]] && [[ -z "$TMUX" ]]; then
#       # tmux attach &>/dev/null  || exec tmux new -A -s default -d
#        # tmux new -A -s default
# fi

eval "$(zoxide init zsh)"

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval $(ssh-agent)
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add ~/.ssh/git
