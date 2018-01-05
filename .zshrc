#!/usr/local/bin/zsh

unalias git

ZPLUG_HOME=/usr/local/opt/zplug
export ZPLUG_HOME
# shellcheck source=/dev/null
source $ZPLUG_HOME/init.zsh

zplug "plugins/aws", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/dircycle", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/emoji", from:oh-my-zsh
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
    # shellcheck disable=SC1091
    if read -rq; then
        echo; zplug install
    fi
fi

zplug load

# shellcheck source=/dev/null
source /usr/local/bin/aws_zsh_completer.sh

for file in ${HOME}/.zshrc.d/*.zshrc; do
  # shellcheck disable=SC1090
  source "${file}"
done


# Don't suggest ZSH typo corrections
unsetopt correct_all

# Allow comments in commands
setopt interactivecomments

# Avoid accidental terminal pause
stty -ixon

# Clobber files with I/O redirection
set -o clobber
