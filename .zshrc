# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="bira"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew github git git-flow dircycle python django osx pip vagrant virtualenvwrapper knife ruby rails gem zsh-syntax-highlighting heroku rvm rails4)

source $ZSH/oh-my-zsh.sh

# Allow clobbering of files with I/O redirection.
set -o clobber

# Set default editors.
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim

export LESSOPEN='| /opt/local/bin/lesspipe.sh %s'

export TERM="xterm-256color"
export GREP_COLOR='2;36'

alias h="history"
alias serve='python -m SimpleHTTPServer'
alias l="ls -p"

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

# virtualenv aliases
alias v='unset AWS_ACCESS_KEY_ID; unset AWS_SECRET_ACCESS_KEY; workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'


stty -ixon

function set_dark()
{
  ${HOME}/bin/gnome-terminal-colors-solarized/set_dark.sh
  eval $(dircolors ${HOME}/bin/dircolors-solarized/dircolors.ansi-dark)
}

function set_light()
{
  ${HOME}/bin/gnome-terminal-colors-solarized/set_light.sh
  eval $(dircolors ${HOME}/bin/dircolors-solarized/dircolors.ansi-light)
}

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
source $HOME/bin/aws_zsh_completer.sh

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

unsetopt correct_all

export PATH=$PATH:$HOME/bin:/opt/local/bin:/opt/local/sbin

PATH=$PATH:/usr/local/rvm/bin # Add RVM to PATH for scripting

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

cookwith() {
    rvm use ruby-1.9.3@chef
    local chef_env=$1
    export CHEF_ENV=${chef_env}
    cd ~/chef/${chef_env}
}

hgrep() {
    history | grep $1
}

getip() {
    wget -qO- icanhazip.com
}

aws-manage() {
    export EC2_HOME=~/.aws-tools

    if [ "$1" = "off" ]; then
        unset EC2_ACCESS_KEY
        unset EC2_SECRET_KEY
        unset EC2_CERT
        unset EC2_PRIVATE_KEY
        unset EC2_PRIVATE_KEY
        unset EC2_CERT
        cd $EC2_HOME && git checkout master | cd -
        unset EC2_HOME
        echo "ec2: off!"
    else
        if [[ -z "$1" ]]; then
            cd $EC2_HOME
            git branch
            cd -
            return
        fi

        if [[ "cd $EC2_HOME | git branch | grep $1" = *$1 ]]; then
            cd $EC2_HOME && git checkout $1 | cd -
            echo "ec2: $1!"
        else
            echo "$1 is not a valid ec2 branch"
        fi

        export PATH=$PATH:$EC2_HOME/bin
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
        export EC2_ACCESS_KEY=$(head -n1 $EC2_HOME/*.credentials | cut -d"=" -f2)
        export EC2_SECRET_KEY=$(tail -n1 $EC2_HOME/*.credentials | cut -d"=" -f2)
        export EC2_PRIVATE_KEY=$(ls $EC2_HOME/*.pk.pem)
        export EC2_CERT=$(ls $EC2_HOME/*.cert.pem)
    fi
}

