#!/usr/local/bin/zsh

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
zplug "lib/clipboard", from:oh-my-zsh
zplug "lib/compfix", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/spectrum", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "supercrabtree/k"
zplug "themes/steeef", from:oh-my-zsh, as:theme

if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

for file in ${HOME}/.zshrc.d/*.zshrc; do
	source "${file}"
done

eval "$(rbenv init -)"
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Don't suggest ZSH typo corrections
unsetopt correct_all

setopt interactivecomments

# Edit the current command line with Ctrl-X,e
autoload edit-command-line
zle -N edit-command-line

# Avoid accidental terminal pause
stty -ixon

# Clobber files with I/O redirection
set -o clobber

################################################################################
# Exports
################################################################################
export JAVA_HOME=$(/usr/libexec/java_home)
export TERM="screen-256color"
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

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
alias aws-fd-perftest-full="aws --profile fd-perftest-full"
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


export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:${NPM_PATH}:$PATH"

# Source host auto-completer
# source $HOME/.internal_hosts

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
