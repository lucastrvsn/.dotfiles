bindkey -v

export KEYTIMEOUT=1

# use vim keys in tab complete menu
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# edit current command line with vim (vim-mode, then v)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
