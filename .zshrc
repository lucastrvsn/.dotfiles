#
# @lucastrvsn zsh config
# adapted from prezto (https://github.com/sorin-ionescu/prezto)
#
# last modified 05 out 2021
#

# tmux init
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux attach -t TMUX || tmux new -s TMUX
fi

# source all configurations
# located inside ~/.config/zsh/*
CONFIGS=(
  plugins
  homebrew
  asdf
  jobs
  directory
  history
  completion
  vi
  title
  aliases
  prompt
)

for config in $CONFIGS; do
  source $HOME/.config/zsh/$config end
done

# vim: ft=zsh

