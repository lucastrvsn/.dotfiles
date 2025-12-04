_prompt_vimode() {
  case ${KEYMAP} in
    vicmd) print -n '%S%#%s' ;;
    *) print -n '%#' ;;
  esac
}

_prompt_user() {
  if [[ $EUID -eq 0 ]]; then
    print -P '%B%F{red}%n%f%b '
  elif [[ -n $SSH_TTY ]]; then
    print -P '%B%F{yellow}%n%f%b@%B%F{green}%m%f%b '
  else
    print -n '%B%F{white}%n%f%b '
  fi
}

_prompt_venv() {
  [[ -n $VIRTUAL_ENV ]] && print -P " %B%F{yellow}${VIRTUAL_ENV:t}%f%b"
}

_prompt_aws() {
  [[ -n $AWS_PROFILE ]] || return
  print -P " aws:%B%F{yellow}${AWS_PROFILE}%f%b"
}

zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select

typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1

setopt nopromptbang prompt{cr,percent,sp,subst}

autoload -Uz add-zsh-hook

# prompt-pwd
zstyle ':zim:prompt-pwd' git-root no
zstyle ':zim:prompt-pwd:fish-style' dir-length 1
zstyle ':zim:prompt-pwd:separator' format '/'

# git-info
typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info' verbose yes
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format 'HEAD %F{green}(%c)'
  zstyle ':zim:git-info:action' format ' %F{yellow}(${(U):-%s})'
  zstyle ':zim:git-info:stashed' format '\\\$'
  zstyle ':zim:git-info:unindexed' format '!%I'
  zstyle ':zim:git-info:indexed' format '+%i'
  zstyle ':zim:git-info:untracked' format '?%u'
  zstyle ':zim:git-info:ahead' format '↑%A'
  zstyle ':zim:git-info:behind' format '↓%B'
  zstyle ':zim:git-info:keys' format \
      'status' '%A%B%i%I%u%S' \
      'prompt' ' %%B%F{magenta}%b%c%s${(e)git_info[status]:+"%F{red}${(e)git_info[status]}"}%f%%b'
  add-zsh-hook precmd git-info
fi

PS1='$(_prompt_user)%B%F{cyan}$(prompt-pwd)%f%b${(e)git_info[prompt]}$(_prompt_venv)$(_prompt_aws)
%B%(1j.%F{blue}*%f .)%(?.%F{green}.%F{red}%? )$(_prompt_vimode)%f%b '
unset RPS1
