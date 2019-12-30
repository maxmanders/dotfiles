#!/usr/local/bin/zsh

alias awswhoami="aws sts get-caller-identity" 
alias be="bundle exec"
alias brew_upgrade='brew update && brew upgrade $(brew outdated)'
alias cat="bat"
alias crontab="VIM_CRONTAB=true crontab"
alias e='exa -l --git'
alias find="fd"
alias gam="cd /usr/local/gam; python gam.py"
alias getname="project-name-generator -o dashed"
alias gfuck="git reset --hard HEAD && git clean -fd && git fetch && git merge origin"
alias gist="gist -c"
alias grep="pcregrep --color=auto"
alias gup="gfo && ggpull"
alias h="history"
alias ls="lsd"
alias l="ll"
alias less='less -m -g -i -J --underline-special --SILENT'
alias mkdir="mkdir -p"
alias more='less'
alias ppv="puppet parser validate"
alias rake="noglob rake"
alias serve='python -m SimpleHTTPServer'
alias sfn="bundle exec sfn"
alias sv="source venv/bin/activate"
alias time-eastern="TZ=America/New_York date"
alias time-pacific="TZ=Canada/Pacific date"
alias time-uk="TZ=Europe/London date"
alias vi='vim'
alias tf='terraform'
alias tg='terragrunt'
alias tfp='terraform plan'
alias tfa='terraform apply'

# Hub `git` aliases
eval "$(hub alias -s)"
