# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
# Combine multiline commands into one in historty
shopt -s cmdhist
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

export EDITOR=vi
export SVN_EDITOR=vi
export GIT_EDITOR=vi
export MYSQL_PS1="\\d@\\h> "

export PATH=${PATH}:/usr/local/bin:~/bin

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

PS1="[\[\033[01;32m\]\u@\h \[\033[01;31m\]\W\[\033[00m\]] $ "

export TERM="xterm-256color"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007";history -a'
    ;;
*)
    PROMPT_COMMAND='history -a'
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias lh='ls -lah'
alias l='ls -CF'
alias gerp='grep'
alias grepr='grep -r'
alias gepr='grep'
alias svnd='svn diff --diff-cmd diff -x -wu'
alias vimwiki='vim -c "VimwikiIndex"'
alias :e='vim'
alias gopen='gnome-open'
alias fsvn='find . -path "*/.svn*" -prune -o -print'
alias pu='pushd'
alias po='popd'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# ignore case, long prompt, exit if it fits on one screen, allow colors for ls a
export LESS="-iMFXR"

# allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

