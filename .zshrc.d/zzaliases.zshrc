#!/usr/local/bin/zsh

alias assume=". assume"
alias awswhoami="aws sts get-caller-identity" 
alias be="bundle exec"
alias brew_upgrade='brew update && brew upgrade $(brew outdated)'
alias cd="z"
alias cx='kubectx'
alias cat="bat --theme Nord "
alias ctags="${HOMEBREW_PREFIX}/bin/ctags"
alias crontab="VIM_CRONTAB=true crontab"
alias diff="${HOMEBREW_PREFIX}/bin/diff"
alias f='flux'
alias find="fd"
alias fw="flux events --watch"
alias gist="gist -c"
alias glow="glow -nlt -w0"
alias grep="pcregrep --color=auto"
alias gup="gfo && ggpull"
alias h="history"
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgd="kubectl get deployments"
alias kittyreload="kill -SIGUSR1 $KITTY_PID"
alias kubectl=kubecolor
alias ls="lsd"
alias l="ll"
alias less='less -m -g -i -J --underline-special --SILENT'
alias mkdir="mkdir -p"
alias more='less'
alias ns='kubens'
alias time-eastern="TZ=America/New_York date"
alias time-pacific="TZ=Canada/Pacific date"
alias time-uk="TZ=Europe/London date"
alias vi='nvim'
alias tf='terraform'
alias tfa='terraform apply'
alias tfaa='terraform apply --auto-approve'
alias tfp='terraform plan'
alias tg='terragrunt'
alias tga='terragrunt apply'
alias tgaa='terragrunt apply --auto-approve'
alias tgp='terragrunt plan'
alias v='nvim'
alias vim='nvim'
