export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "plugins/aws", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/dircycle", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/virtualenv", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh
zplug "lib/compfix", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "themes/steeef", from:oh-my-zsh, as:theme

if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Source tmuxinator integration
source $HOME/bin/tmuxinator.zsh

# Don't suggest ZSH typo corrections
unsetopt correct_all

# Edit the current command line with Ctrl-X,e
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# Ctrl-U: kill from cursor to start of line
bindkey '^U' backward-kill-line

# Ctrl-Y: Yank killed lines back to the command line
bindkey '^Y' yank

# Avoid accidental terminal pause
stty -ixon

# Clobber files with I/O redirection
set -o clobber

################################################################################
# Exports
################################################################################
export JAVA_HOME=$(/usr/libexec/java_home)
export TERM="screen-256color"

# Set default editors
export EDITOR=vim
alias vi='vim'
export SVN_EDITOR=vim
export GIT_EDITOR=vim

# Make `less` a little nicer
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
alias less='less -m -g -i -J --underline-special --SILENT'
alias more='less'

# if type nvim > /dev/null 2>&1; then
  # alias vim='nvim'
# fi

# Integrate GitHub's Hub command aliases for the `git` command
eval "$(hub alias -s)"

################################################################################
# Aliases
################################################################################
alias rake="noglob rake"
alias h="history"
alias serve='python -m SimpleHTTPServer'
alias l="ls -p"
alias mkdir="mkdir -p"
alias gam="cd /usr/local/gam; python gam.py"
alias aws-fd-power="aws --profile fd-power"
alias aws-fd-power-no-mfa="aws --profile fd-power-no-mfa"
alias aws-fd-full="aws --profile fd-full"
alias aws-fd-perftest-full="aws --profile fd-dev-full"
alias aws-fd-dev-full="aws --profile fd-dev-full"
alias aws-turbo-full="aws --profile turbo-full"
alias aws-fd-uk-full="aws --profile fd-uk-full"
alias aws-fd-dr-full="aws --profile fd-dr-full"
alias ppv="puppet parser validate"
alias time-eastern="TZ=America/New_York date"
alias time-pacific="TZ=Canada/Pacific date"
alias time-uk="TZ=Europe/London date"
alias be="bundle exec"
alias brew_upgrade="brew update && brew upgrade $(brew outdated)"
alias sfn="bundle exec sfn"
alias grep="pcregrep --color=auto"
alias gup="gfo && ggpull"
alias gfuck="git reset --hard HEAD && git clean -fd && git fetch && git merge origin"
alias gist="gist -c"
alias crontab="VIM_CRONTAB=true crontab"

source /usr/local/bin/aws_zsh_completer.sh

################################################################################
# Searches history for $1 and outputs those commands that match the search
# term.
# Arguments:
#   $1: a term to search history for
# Returns:
#   None
################################################################################
function hgrep() {
    string=$@
    history | grep -i "${string}"
}

setbg() {
  local bg="${1}"
  if egrep -q -i "light|dark" <(echo ${bg}); then
    vim -c ":set background=${bg}" +Tmuxline +qall
  fi
}

eval "$(rbenv init -)"

# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

################################################################################
# Search for EC2 instances with a name tag containing $1, and print a row for
# each result with the following columns: InstanceId, PrivateIpAddress, Name.
# Arguments:
#   $1: a name tag to search for
# Returns:
#   None
################################################################################
function instances_by_name() {
    aws ec2 describe-instances --filter "Name=tag:Name,Values=*${1}*" | \
    jq ".Reservations[].Instances[] | \
            .InstanceId, \
            .PrivateIpAddress, \
            (.Tags[] | select(.Key == \"Name\") | \
            .Value)" | \
    sed 's/"//g' | \
    paste - - -
}

################################################################################
# Prints out useful information about an EC2 instance, given an InstanceId.
# Arguments:
#   $1: an InstanceId to search for
# Returns:
#   None
################################################################################
function i() {
    aws ec2 describe-instances --instance-id ${1} | \
    jq -r ".Reservations[].Instances[] | \
                \"InstanceId: \(.InstanceId)\", \
                \"IP Address: \(.PrivateIpAddress)\", \
                (.Tags[] | \"\(.Key): \(.Value)\")"
}

################################################################################
# Prints out the EC2 InstanceIds and PrivateIPAddresses for all instances in
# the given Auto-Scaling Group.
# Arguments:
#   $1: an Auto-Scaling Group name to search for
# Returns:
#   None
################################################################################
function asg_instances() {
    aws ec2 describe-instances --instance-ids $(
    aws autoscaling describe-auto-scaling-groups \
        --auto-scaling-group-name ${1} | \
    jq ".AutoScalingGroups[].Instances[] | .InstanceId" | \
    sed 's/"//g' | \
    paste -) | \
    jq ".Reservations[].Instances[] | \
            .InstanceId, \
            .PrivateIpAddress" | \
    sed 's/"//g' | \
    paste - -
}

################################################################################
# Prints out the endpoint for the given RDS InstanceIdentifier, or all
# for all InstanceIdentifiers if none is given
# Arguments:
#   $1: an InstanceIdentifier to search for
# Returns:
#   None
################################################################################
function rds_instances() {
    param=""
    if [ $# -eq 1 ]; then
        param="--db-instance-identifier ${1}"
    fi
    cmd="aws rds describe-db-instances ${param}"

    eval ${cmd} | \
    jq ".DBInstances[] | \
        .DBInstanceIdentifier, \
        .Endpoint.Address" | \
    sed 's/"//g' | \
    paste - - | \
    column -t
}

################################################################################
# Prints out the description of an ElastiCache replication group, given
# a replication group identifier
# Arguments:
#   $1: a ReplicationGroup identifier
# Returns:
#   None
################################################################################
function ecwat() {
    aws elasticache describe-replication-groups --replication-group-id $1 \
        --query "ReplicationGroups[].Description"
}

################################################################################
# Search `git ls-files`
# Arguments:
#   $1: a term to search for
# Returns:
#   None
################################################################################
function gfind() {
    git ls-files | grep -i $1
}

################################################################################
# Prints out your public IP.
# Arguments:
#   None
# Returns:
#   None
################################################################################
function getip() {
    wget -qO- checkip.amazonaws.com
}

################################################################################
# Prints out your public IP.
# Arguments:
#   None
# Returns:
#   None
################################################################################
function getlocalip() {
    if [[ "$(uname)" == 'Darwin' ]]; then
        networksetup -getinfo Wi-Fi | awk '/^IP address/'
    fi
}

################################################################################
# SSH as root to an EC2 instance by IP
# Arguments:
#   None
# Returns:
#   None
################################################################################
function ssh_instance() {
  address=$(aws ec2 describe-instances --instance-ids $1 | \
  jq -r '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')

  ssh root@${address}
}

################################################################################
# SSH wrapper to rename TMUX window title with the connected hostname.
# Arguments:
#   None
# Returns:
#   None
################################################################################
function ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

function brdone() {
  to_delete=$(git rev-parse --abbrev-ref HEAD)
  git co production && git br -D "${to_delete}" && gup && unset to_delete
}

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:${NPM_PATH}:$PATH"

# Source host auto-completer
# source $HOME/.internal_hosts

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
