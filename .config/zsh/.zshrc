[ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"

HISTFILE="$XDG_STATE_HOME/zsh/history"

typeset -U path # declare $PATH as a unique array

# saner defaults
setopt autocd # auto cd into directory.
setopt nomatch # output error if file doesn't match
setopt interactive_comments # comments in interactive shells
setopt PROMPT_SP # enable preservation of trailing spaces in prompt
stty stop undef # disable ctrl-s to freeze terminal.
zle_highlight=('paste:none') # don't highlight paste

# history in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# load prompt, aliases, functions
[ -f "$ZDOTDIR/prompt" ] && source "$ZDOTDIR/prompt"
[ -f "$XDG_CONFIG_HOME/shell/aliases" ] && source "$XDG_CONFIG_HOME/shell/aliases"
[ -f "$XDG_CONFIG_HOME/shell/functions" ] && source "$XDG_CONFIG_HOME/shell/functions"

# basic auto/tab complete
fpath=($fpath "$XDG_CONFIG_HOME/zsh/completions") # custom completions
autoload -U compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # include hidden files

# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# key binds
bindkey '^R' history-incremental-search-backward
#command -v tmux-sessionizer > /dev/null && bindkey -s '^F' "tmux-sessionizer^M"
# bindkey '^[[A' up-line-or-search
# bindkey '^[[B' down-line-or-search
bindkey '^[OA' history-substring-search-up
bindkey '^[[A' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey '^[[B' history-substring-search-down

# init tmux
#command -v tmux-init > /dev/null && tmux-init


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

ZSH_PLUGIN_DIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
ZSH_HIGHLIGHT_DIR="$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
ZSH_HISTORY_SUBSTRING_SEARCH_DIR="$ZSH_PLUGIN_DIR/zsh-history-substring-search"
[ -f "$ZSH_HIGHLIGHT_DIR/zsh-syntax-highlighting.zsh" ] && source "$ZSH_HIGHLIGHT_DIR/zsh-syntax-highlighting.zsh"
[ -f "$ZSH_HISTORY_SUBSTRING_SEARCH_DIR/zsh-history-substring-search.zsh" ] && source "$ZSH_HISTORY_SUBSTRING_SEARCH_DIR/zsh-history-substring-search.zsh"


# DRIBIA
[ -f /home/tomas/repositories/dribia/sotweaks/sotweaks/bashrc_v2.sh ] && source /home/tomas/repositories/dribia/sotweaks/sotweaks/bashrc_v2.sh


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
