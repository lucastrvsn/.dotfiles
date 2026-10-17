export GPG_TTY=$TTY
export HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/opt/homebrew}
export CARGO_HOME=${CARGO_HOME:-$HOME/.cargo}
export RUSTUP_HOME=${RUSTUP_HOME:-$HOME/.rustup}
export DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
export NPM_GLOBAL=${NPM_GLOBAL:-$HOME/.npm-global}

# zim's completion module runs compinit, so extra completion dirs must be on fpath first
fpath=($DOCKER_CONFIG/completions(N) $fpath)

# Download zimfw plugin manager if missing
if [[ ! -e $ZIM_HOME/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o $ZIM_HOME/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update $ZIM_HOME/init.zsh if missing or outdated
if [[ ! $ZIM_HOME/init.zsh -nt $ZIM_CONFIG_FILE ]]; then
  source $ZIM_HOME/zimfw.zsh init -q
fi

source $ZIM_HOME/init.zsh

# -U drops duplicates, so nested shells don't grow PATH
typeset -U path
path=(
  $HOMEBREW_PREFIX/opt/rustup/bin
  $CARGO_HOME/bin
  $DOCKER_CONFIG/bin
  $XDG_BIN_HOME
  $path
)

source $XDG_CONFIG_HOME/zsh/npm
source $XDG_CONFIG_HOME/zsh/aliases
source $XDG_CONFIG_HOME/zsh/keybindings
source $XDG_CONFIG_HOME/zsh/prompt
