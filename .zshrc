# Load plugins
source $HOME/.antigen.zsh

antigen use oh-my-zsh

antigen bundle asdf
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
antigen bundle yarn
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load spaceship theme
antigen theme denysdovhan/spaceship-prompt

# Apply all plugins and theme
antigen apply

# default configs
EDITOR="nvim"

# spaceship configs
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="$ "
SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=always

# alias for vim
alias vim=nvim
alias vi=nvim
alias v=nvim

# changing ls to exa
alias ls="exa -al --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first"
