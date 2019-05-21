#!/usr/local/bin/zsh

alias aws-fd-aw-full="aws --profile fd-aw-full"
alias aws-fd-dev-full="aws --profile fd-dev-full"
alias aws-fd-dr-full="aws --profile fd-dr-full"
alias aws-fd-full="aws --profile fd-full"
alias aws-fd-perftest-full="aws --profile fd-perftest-full"
alias aws-fd-power-no-mfa="aws --profile fd-power-no-mfa"
alias aws-fd-power="aws --profile fd-power"
alias aws-fd-uk-full="aws --profile fd-uk-full"
alias aws-nf-full="aws --profile nf-full"
alias aws-turbo-full="aws --profile turbo-full"
alias be="bundle exec"
alias brew_upgrade='brew update && brew upgrade $(brew outdated)'
alias cat="bat"
alias crontab="VIM_CRONTAB=true crontab"
alias e='exa -l --git'
alias gam="cd /usr/local/gam; python gam.py"
alias getname="project-name-generator -o dashed"
alias gfuck="git reset --hard HEAD && git clean -fd && git fetch && git merge origin"
alias gist="gist -c"
alias grep="pcregrep --color=auto"
alias gup="gfo && ggpull"
alias h="history"
alias ls="lsd"
alias l="ls -p"
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

# Hub `git` aliases
eval "$(hub alias -s)"
