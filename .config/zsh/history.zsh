setopt bang_hist
setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_verify
setopt hist_beep

HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zhistory}"
HISTSIZE=10000
SAVEHIST=10000
