#!/usr/local/bin/zsh

$(alias -L | grep -qi "git=") && unalias git

ZPLUG_HOME=/usr/local/opt/zplug
export ZPLUG_HOME
# shellcheck source=/dev/null
source $ZPLUG_HOME/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme, at:indestructible-pure
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/dircycle", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/emoji", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/pipenv", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/terraform", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh
zplug "lib/compfix", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/spectrum", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check; then
    printf "Install? [y/N]: "
    # shellcheck disable=SC1091
    if read -rq; then
        echo; zplug install
    fi
fi

zplug load

# shellcheck source=/dev/null
source $HOME/bin/aws_zsh_completer.sh

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


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/max/dev/currenthealth/serverless-ec2-backups/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/max/dev/currenthealth/serverless-ec2-backups/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/max/dev/currenthealth/serverless-ec2-backups/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/max/dev/currenthealth/serverless-ec2-backups/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/max/dev/currenthealth/serverless-ec2-backups/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/max/dev/currenthealth/serverless-ec2-backups/node_modules/tabtab/.completions/slss.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
