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
plugins=(brew github git git-flow dircycle python django osx pip vagrant virtualenvwrapper knife ruby rails gem zsh-syntax-highlighting heroku rvm)

source $ZSH/oh-my-zsh.sh

set -o clobber

# Customize to your needs...
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

export TERM="xterm-256color"
export GREP_COLOR='2;36'

alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"
alias h="history"
alias serve='python -m SimpleHTTPServer'
alias l="ls -p"

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
    local chef_env=$1
    export CHEF_ENV=${chef_env}
}

hgrep() {
    history | grep $1
}

getip() {
    wget -qO- icanhazip.com
}
