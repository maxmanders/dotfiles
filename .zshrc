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
plugins=(aws brew colorize colored-man github git git-flow dircycle python django osx pip vagrant virtualenv knife ruby rails gem zsh-syntax-highlighting heroku ssh-agent urltools web-search zsh-syntax-highlighting vundle tmux rvm)

source $ZSH/oh-my-zsh.sh

# Allow clobbering of files with I/O redirection.
set -o clobber

# Set default editors.
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim

export PKG_CONFIG_PATH="/usr/local/Cellar/imagemagick/6.9.1-4/lib/pkgconfig:$PKG_CONFIG_PATH"

export JAVA_HOME=$(/usr/libexec/java_home)
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS='-R'

export TERM="xterm-256color"
export GREP_COLOR='2;36'

alias rake="noglob rake"
alias h="history"
alias serve='python -m SimpleHTTPServer'
alias l="ls -p"
alias mkdir="mkdir -p"
alias gam="cd /usr/local/gam; python gam.py"

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

unsetopt correct_all


autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

bindkey '^U' backward-kill-line
bindkey '^Y' yank

# SSH AutoCompleter
if [[ -r ~/.ssh/known_hosts ]]
then
    _known_hosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
fi
_known_hosts+=("${(f)$(dig axfr east.fdbox.net @dns-1.east.fdbox.net | egrep 'IN\s(A|CNAME)' | awk '{print substr($1, 0, length($1)-1)}')}")
zstyle ':completion:*:hosts' hosts $_known_hosts

hgrep() {
    history | grep -i $1
}

gamfor() {
    cd /usr/local/gam
    export OAUTHFILE="${1}.txt"
}

getip() {
    wget -qO- checkip.amazonaws.com
}

getlocalip()
{
    networksetup -getinfo Wi-Fi
}

ssh_instance() {
  address=$(aws ec2 describe-instances --instance-ids $1 | jq -r '.Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress')
  ssh root@${address}
}

export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
export PYTHONSTARTUP=$HOME/.pythonrc.py

eval "$(hub alias -s)"
[[ -s "$HOME/.rvm/scripts/rvm"  ]] && . "$HOME/.rvm/scripts/rvm"

if [ -f ~/.gpg-agent-info ]; then
    source ~/.gpg-agent-info
    export GPG_AGENT_INFO
    export GPG_TTY=$(tty)
fi

PERL_MB_OPT="--install_base \"/Users/max/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/max/perl5"; export PERL_MM_OPT;

export PATH="$HOME/.rvm/bin:$PATH:/usr/local/bin:$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/gam:/usr/local/bin/:/usr/local/google_appengine/"

source /Users/max/.iterm2_shell_integration.zsh
