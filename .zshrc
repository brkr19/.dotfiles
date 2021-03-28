#!/usr/bin/env zsh

export DOTFILES=$HOME/.dotfiles
export INCLUDES=$DOTFILES/zsh-plugins

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
PATH=$PATH:~/.local/bin:/usr/sbin:~/go/bin


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

# Prompts
PROMPT_EOL_MARK=''
PROMPT='%B%F{202}[%F{255}%~%F{202}] %F{117}%(!.#.$)%f%b '

preexec() {
}

precmd() {
  if [[ -n "$PRINT_CMD_DTM" ]]; then
    echo && print -P %F{250}$(date -Iseconds)%f && echo
  fi
}

export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Show percentage during 'less' command
export LESS='eFRX -Pslines %lt-%lb (%Pb\%) file %f'

export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
