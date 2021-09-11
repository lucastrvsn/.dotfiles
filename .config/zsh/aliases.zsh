# preference
alias m='less'
alias vim='nvim'

# better ls defaults
alias ls='ls -GFh'
alias la='ls -GAFh'
alias ll='ls -GAFhl'

# git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gs='git status'
alias gp='git pull'
alias gm='git merge'
alias gp='git push'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias glog='git log --oneline --decorate --graph'
alias gfp='git fetch --prune'
alias gdlb='git branch -r | awk "{print $1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print $1}" | xargs git branch -D'
alias gdd='fetch_and_delete_branches'

# history
alias h='history'
alias hg='history -1000 | grep -i'
alias history-10='history 0 | awk "{print \$2}" | sort | uniq -c | sort -n -r | head'
