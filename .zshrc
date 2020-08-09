# antigen {{{
source $HOME/.antigen.zsh

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle b4b4r07/enhancd
antigen bundle b4b4r07/emoji-cli
antigen bundle asdf
antigen bundle git
antigen bundle node
antigen bundle npm
antigen bundle yarn
antigen bundle tmux
antigen theme denysdovhan/spaceship-prompt

antigen apply
# }}}

# zsh config
EDITOR="nvim"
CASE_SENSITIVE="false"

# spaceship config
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="$ "
SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=always

# alias for vim
alias vim=nvim
alias vi=nvim
alias v=nvim

