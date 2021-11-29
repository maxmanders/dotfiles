# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/usr/local/bin/zsh

# zmodload zsh/zprof

$(alias -L | grep -qi "git=") && unalias git

ZPLUG_HOME=/usr/local/opt/zplug
export ZPLUG_HOME
# shellcheck source=/dev/null
source $ZPLUG_HOME/init.zsh

zplug "mafredri/zsh-async", from:"github"
# zplug "sindresorhus/pure", use:"pure.zsh", from:"github", as:"theme"
zplug romkatv/powerlevel10k, as:theme, depth:1 

zplug "plugins/aws", from:"oh-my-zsh"
zplug "plugins/colored-man-pages", from:"oh-my-zsh"
zplug "plugins/docker", from:"oh-my-zsh"
zplug "plugins/fd", from:"oh-my-zsh"
zplug "plugins/git", from:"oh-my-zsh"
zplug "plugins/github", from:"oh-my-zsh"
zplug "plugins/golang", from:"oh-my-zsh"
zplug "plugins/gpg-agent", from:"oh-my-zsh"
zplug "plugins/pip", from:"oh-my-zsh"
zplug "plugins/pipenv", from:"oh-my-zsh"
zplug "plugins/ssh-agent", from:"oh-my-zsh"
zplug "plugins/terraform", from:"oh-my-zsh"
zplug "plugins/vagrant", from:"oh-my-zsh"
zplug "zsh-users/zsh-completions", from:"github"

zplug "lib/clipboard", from:"oh-my-zsh"
zplug "lib/compfix", from:"oh-my-zsh"
zplug "lib/completion", from:"oh-my-zsh"
zplug "lib/directories", from:"oh-my-zsh"
zplug "lib/history", from:"oh-my-zsh"
zplug "lib/key-bindings", from:"oh-my-zsh"
zplug "lib/spectrum", from:"oh-my-zsh"

if ! zplug check; then
    printf "Install? [y/N]: "
    # shellcheck disable=SC1091
    if read -rq; then
        echo; zplug install
    fi
fi

zplug load

# shellcheck source=/dev/null
autoload bashcompinit && bashcompinit
autoload -U compinit && compinit
complete -C aws_completer aws
complete -C aws_completer sudo
complete -C aws_completer aws-vault

for file in ${HOME}/.zshrc.d/*.zshrc; do
  # shellcheck disable=SC1090
  source "${file}"
done

# Nicer directory navigation
setopt autocd autopushd pushdignoredups

# Don't suggest ZSH typo corrections
unsetopt correct_all

# Allow comments in commands
setopt interactivecomments

# Avoid accidental terminal pause
stty -ixon

# Clobber files with I/O redirection
set -o clobber

# Dedup PATH
export PATH=$(printf %s "$PATH" | awk -vRS=: '!a[$0]++' | paste -s -d:)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
