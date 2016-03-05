ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
plugins=(aws brew colorize colored-man github git git-flow dircycle python django osx pip vagrant virtualenv knife ruby rails gem zsh-syntax-highlighting heroku gpg-agent ssh-agent urltools web-search zsh-syntax-highlighting vundle tmux rvm emoji npm)

source $ZSH/oh-my-zsh.sh

# Allow clobbering of files with I/O redirection.
set -o clobber

# Set default editors.
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim
export JAVA_HOME=$(/usr/libexec/java_home)

export LESSOPEN="| source-highlight -f esc -i %s -o STDOUT"
export LESS=" -R "
alias less='less -m -N -g -i -J --underline-special --SILENT'
alias more='less'

export TERM="screen-256color"
export GREP_COLOR='2;36'

alias rake="noglob rake"
alias h="history"
alias serve='python -m SimpleHTTPServer'
alias l="ls -p"
alias mkdir="mkdir -p"
alias gam="cd /usr/local/gam; python gam.py"
alias aws-fd-power="aws --profile fd-power"
alias aws-fd-power-no-mfa="aws --profile fd-power-no-mfa"
alias aws-fd-full="aws --profile fd-full"
alias aws-turbo-full="aws --profile turbo-full"
alias ppv="puppet parser validate"
alias time-eastern="TZ=America/New_York date"
alias time-pacific="TZ=Canada/Pacific date"
alias time-uk="TZ=Europe/London date"
alias be="bundle exec"
alias brew_upgrade="brew update && brew upgrade $(brew outdated)"

stty -ixon

kernel=`uname -s`
case $kernel in
    Darwin)
        export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
    ;;
    Linux)
        eval $(dircolors ~/.dircolors.ansi-dark)
    ;;
    *) ;;
esac

#autoload

# AWS Settings
export AWS_CONFIG_FILE=${HOME}/.awsconfig

unsetopt correct_all

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

bindkey '^U' backward-kill-line
bindkey '^Y' yank

# SSH AutoCompleter
source $HOME/.internal_hosts
source $HOME/.krbchrome

function hgrep() {
    history | grep -i $1
}

function instances_by_name() {
    aws ec2 describe-instances --filter "Name=tag:Name,Values=*${1}*"  | jq  '.Reservations[].Instances[] | .InstanceId,(.Tags[] | select(.Key == "Name") | .Value)' | sed 's/"//g' | paste - -
}

function i() {
    aws ec2 describe-instances --instance-id ${1} |\
      jq -r '.Reservations[].Instances[] | "InstanceId: \(.InstanceId)", "IP Address: \(.PrivateIpAddress)", (.Tags[] | "\(.Key): \(.Value)")'
}

function asg_instances() {
    aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${1} --output json --query "AutoScalingGroups[].Instances[].InstanceId"
}

function rds_instances() {
    if [ $# -eq 1 ]; then
        aws rds describe-db-instances --db-instance-identifier ${1} | jq '.DBInstances[] | "DBInstanceIdentifier: \(.DBInstanceIdentifier) | EndpointAddress: \(.Endpoint.Address)"'
    else
        aws rds describe-db-instances | jq '.DBInstances[] | "DBInstanceIdentifier: \(.DBInstanceIdentifier) | EndpointAddress: \(.Endpoint.Address)"'
    fi
}
function getip() {
    wget -qO- checkip.amazonaws.com
}

function getlocalip()
{
    networksetup -getinfo Wi-Fi
}

function ssh_instance() {
  address=$(aws ec2 describe-instances --instance-ids $1 | jq -r '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')
  ssh rbot@${address}
}

function ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

function ne {
   $(npm bin)/$@  
}

export PYTHONSTARTUP=$HOME/.pythonrc.py

eval "$(hub alias -s)"

PERL_MB_OPT="--install_base \"/Users/max/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/max/perl5"; export PERL_MM_OPT;

source $HOME/.iterm2_shell_integration.zsh

export PATH="/usr/local/bin:$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/gam:/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/Users/max/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
NPM_PACKAGES=/Users/max/.npm-packages
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
