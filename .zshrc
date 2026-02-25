#!/usr/bin/env zsh

export DOTFILES=$HOME/.dotfiles
export INCLUDES=$DOTFILES/zsh-plugins
export TMUX_AUTO_ATTACH=1
export PIPX_HOME=/tools/pipx
export PIPX_BIN_DIR=/tools/pipx/bin

# Source Files
source $DOTFILES/aliases
source $DOTFILES/variables

if [[ -f $HOME/.zshrc_local ]]; then
    source $HOME/.zshrc_local
fi

ZSH_SYNTAX_HIGHLIGHTING=$INCLUDES/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_COMPLETIONS=$INCLUDES/zsh-completions/zsh-completions.plugin.zsh
ZSH_HISTORY_SUBSTRING_SEARCH=$INCLUDES/zsh-history-substring-search/zsh-history-substring-search.zsh

PLUGINS=(
    $ZSH_SYNTAX_HIGHLIGHTING
    $ZSH_COMPLETIONS
    $ZSH_HISTORY_SUBSTRING_SEARCH
)


for plugin in $PLUGINS; do
    if [[ -f $plugin ]]; then
        source $plugin
    fi
done


# History Settings
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL=ignoreboth
setopt HIST_IGNORE_SPACE

# Highlight Settings
zle_highlight+=(paste:none)

# Completion Settings
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'


# Set Paths
PATH=$PATH:~/.local/bin:/usr/sbin:~/go/bin:$PIPX_BIN_DIR
GOPATH=~/go


# ZSH settings
autoload -U compinit && compinit
zmodload -i zsh/complist

unsetopt menu_complete
unsetopt flowcontrol

setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt interactivecomments
setopt share_history

bindkey -v
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey "^r" history-incremental-pattern-search-backward
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export KEYTIMEOUT=1

# Fix bracketed paste mode in vi mode - prevent last character case toggle
# when pasting commands without trailing newline
unset zle_bracketed_paste

# Prompts
PROMPT_EOL_MARK=''
PROMPT='%B%F{202}[%F{255}%~%F{202}] %F{117}%(!.#.$)%f%b '

preexec() {
}

precmd() {
  NEWLINE=$'\n'
  ONELINE='%B%F{202}[%F{254}%~%F{202}] %F{117}%(!.#.$)%f%b '
  TWOLINE='%B%F{202}┌──[%F{254}%~%F{202}] ${NEWLINE}└─ %F{117}%(!.#.$)%f%b '

  if [[ -n "$PROMPT_LINE_OVERRIDE" ]]; then
    if [[ "$PROMPT_LINE_OVERRIDE" -eq 1 ]]; then
      PROMPT="$ONELINE"
    elif [[ "PROMPT_LINE_OVERRIDE" -eq 2 ]]; then
      PROMPT="$TWOLINE"
    fi
  else 
    PROMPT="$TWOLINE"
  fi


  if [[ -n "$PRINT_CMD_DTM" ]]; then
    echo && print -P %F{250}$(date -Iseconds)%f && echo
  fi
}

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Show percentage during 'less' command
export LESS='eFRX -Pslines %lt-%lb (%Pb\%) file %f'

export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

if [ -z "$TMUX" ]; then
  DEFAULT_TMUX_SESSION=default

  # Create a new default session if one doesn't exist
  if ! tmux has -t $DEFAULT_TMUX_SESSION 2>/dev/null; then
    tmux new -d -t $DEFAULT_TMUX_SESSION
  fi

  # Create a new project session if one doesn't exist
  if [ -n "$PROJECTNAME" ]; then
    DEFAULT_TMUX_SESSION=$PROJECTNAME

    if ! tmux has -t "$PROJECTNAME" 2>/dev/null; then
      tmux new -d -t $PROJECTNAME
    fi
  fi

  # Connect to a session automatically
  if [ -n "$TMUX_AUTO_ATTACH" ]; then
    tmux a -t $DEFAULT_TMUX_SESSION
  fi
fi

if [ -n "$TMUX" ]; then
  export TERM=screen-256color

  unset TMUX_SESSIONS
  declare -a TMUX_SESSIONS

  for session in $(tmux ls -F "#{session_name}"); do
    TMUX_SESSIONS+=( $session )
  done
  unset session

  if [ $(tmux list-windows | wc -l) -eq "1" ] && [ $(tmux list-panes | wc -l) -eq "1" ]; then
    tput setaf 117

    echo
    tput setaf 202
    echo "--------------------------------------------------"
    tput setaf 117
    tput bold
    echo "Active TMUX Sessions"
    tput bold
    for session in "${TMUX_SESSIONS[@]}"; do
      echo " $(tput setaf 202)/$(tput setaf 117) $session"
    done
    unset session
    echo

    if [ -n "$TMUX_AUTO_ATTACH" ]; then
      echo "Disable auto-TMUX by adding to ~/.zshrc_local:"
      echo "  unset TMUX_AUTO_ATTACH" 
    fi

    tput setaf 202
    echo "--------------------------------------------------"
    tput setaf 117
    echo

    tput sgr0
  fi
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
