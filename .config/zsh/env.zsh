# append to path
HOMEBREW_BIN_PATH="/opt/homebrew/bin"
HOMEBREW_SBIN_PATH="/opt/homebrew/sbin"
CARGO_BIN_PATH="$HOME/.cargo/bin"
export PATH="$HOMEBREW_BIN_PATH:$HOMEBREW_SBIN_PATH:$CARGO_BIN_PATH:$PATH"

# lscolors
export CLICOLOR=1
export LSCOLORS=Dxfxcxdxbxegedabadacad

# defaults
export EDITOR="nvim"
export VISUAL=$EDITOR
export PAGER="less"
export MANPAGER="nvim -c 'set ft=man' -"

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -a zsh/mapfile mapfile
