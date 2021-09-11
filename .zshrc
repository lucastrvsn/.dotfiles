#
# @lucastrvsn zsh config
# adapted from prezto (https://github.com/sorin-ionescu/prezto)
#

# Autostart tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux attach -t TMUX || tmux new -s TMUX
fi

# Load all my configurations
source $HOME/.config/zsh/plugins.zsh
source $HOME/.config/zsh/homebrew.zsh
source $HOME/.config/zsh/prompt.zsh
source $HOME/.config/zsh/directory.zsh
source $HOME/.config/zsh/history.zsh
source $HOME/.config/zsh/completion.zsh
source $HOME/.config/zsh/vi.zsh
source $HOME/.config/zsh/title.zsh
source $HOME/.config/zsh/aliases.zsh

# Load starship
eval "$(starship init zsh)"

# Created by `pipx` on 2021-09-09 14:25:22
export PATH="$PATH:/Users/lucas/.local/bin"
