# Load plugins
source $HOME/.antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle archlinux
antigen bundle cargo
antigen bundle docker-compose
antigen bundle docker
antigen bundle emoji
antigen bundle node
antigen bundle npm
antigen bundle npx
antigen bundle rust
antigen bundle tmux
antigen bundle yarn
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load spaceship theme
antigen theme denysdovhan/spaceship-prompt

# Apply all plugins and theme
antigen apply

# Spaceship configuration
SPACESHIP_CHAR_SYMBOL="$ "
SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=always

# Zsh aliases
alias vim=nvim
alias vi=nvim
alias v=nvim
