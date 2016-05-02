ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
plugins=(aws brew colorize colored-man-pages github git git-flow dircycle python django osx pip vagrant virtualenv ruby rails gem gpg-agent ssh-agent urltools web-search vundle rvm emoji npm tmux)
source $ZSH/oh-my-zsh.sh
source $HOME/.iterm2_shell_integration.zsh

# Source host auto-completer
source $HOME/.internal_hosts

# Don't suggest ZSH typo corrections
unsetopt correct_all

# Open the current command line in the default editor with Ctrl-X,e
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# Ctrl-U: kill frmo cursor to start of line
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
export SVN_EDITOR=vim
export GIT_EDITOR=vim

# Make `less` a little nicer
export LESSOPEN="| source-highlight -f esc -i %s -o STDOUT"
export LESS=" -R "
alias less='less -m -N -g -i -J --underline-special --SILENT'
alias more='less'

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
alias aws-fd-dev-full="aws --profile fd-dev-full"
alias aws-turbo-full="aws --profile turbo-full"
alias ppv="puppet parser validate"
alias time-eastern="TZ=America/New_York date"
alias time-pacific="TZ=Canada/Pacific date"
alias time-uk="TZ=Europe/London date"
alias be="bundle exec"
alias brew_upgrade="brew update && brew upgrade $(brew outdated)"
alias sfn="bundle exec sfn"
alias grep="pcregrep --color=auto"
alias gup="gfo && ggpull"


################################################################################
# Searches history for $1 and outputs those commands that match the search
# term.
# Arguments:
#   $1: a term to search history for
# Returns:
#   None
################################################################################
function hgrep() {
    history | grep -i $1
}

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

################################################################################
# As with Bundler, running `bundle exec`, do something similar for local NPM
# binaries.
# Arguments:
#   None
# Returns:
#   None
################################################################################
function ne {
   $(npm bin)/$@  
}

# Set up NVM
export NVM_DIR="/Users/max/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
NPM_PATH="$NPM_PACKAGES/bin"

export PATH="$HOME/.rvm/bin:${NPM_PATH}:/usr/local/bin:$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/gam:/usr/local/bin:$PATH"

# Set up RVM
[[ -s "$HOME/.rvm/scripts/rvm"  ]] && . "$HOME/.rvm/scripts/rvm" 
