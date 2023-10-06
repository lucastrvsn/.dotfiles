# adapted from prezto (https://github.com/sorin-ionescu/prezto)

# source all configurations inside ~/.config/zsh/*
CONFIGS=(
  asdf
  plugins
  jobs
  directory
  history
  completion
  prompt
  search
  fzf
  forgit
  aliases
)

for config in $CONFIGS; do
  source $HOME/.config/zsh/$config end
done

# vim: ft=zsh
