# https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_BIN_HOME="${XDG_BIN_HOME:=$HOME/.local/bin}"
if [[ $OSTYPE == 'darwin'* ]]; then
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/Library/Caches}"
else
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
fi
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:=$TMPDIR/runtime-$UID}"
export XDG_STATE_HOME="${XDG_STATE_HOME:=$HOME/.local/state}"

if [[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]]; then
  export PATH="$XDG_BIN_HOME:$PATH"
fi

export GPG_TTY=$(tty)
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"
export PAGER="less"

# zimfw
export ZIM_CONFIG_FILE="${ZDOTDIR:-${HOME}}/.zimrc"
export ZIM_HOME="${ZDOTDIR:-${HOME}}/.zim"

# cargo binaries
export CARGO_HOME="${CARGO_HOME:=$HOME/.cargo}"
if [[ ":$PATH:" != *":$CARGO_HOME/bin:"* ]]; then
  export PATH="$CARGO_HOME/bin:$PATH"
fi
