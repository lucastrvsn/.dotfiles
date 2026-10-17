export XDG_BIN_HOME=${XDG_BIN_HOME:-$HOME/.local/bin}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"
export PAGER="less"

# zimfw
export ZIM_CONFIG_FILE=${ZDOTDIR:-$HOME}/.zimrc
export ZIM_HOME=${ZDOTDIR:-$HOME}/.zim
