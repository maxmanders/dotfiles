source ${HOME}/.zplug/init.zsh

zplug "mafredri/zsh-async", from:"github"

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
    printf "Install zplug plugins? [y/N]: "
    # shellcheck disable=SC1091
    if read -rq; then
        echo; zplug install
    fi
fi

zplug load

for file in ${HOME}/.zshrc.d/*.zshrc; do
  # shellcheck disable=SC1090
  source "${file}"
done

# shellcheck source=/dev/null
HOMEBREW_PREFIX="$(brew --prefix)"
fpath=(${HOME}/.zshrc.d/completions/ $fpath)
fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
fpath=(${HOME}/.granted/zsh_autocomplete/assume/ $fpath)
fpath=(${HOME}/.granted/zsh_autocomplete/granted/ $fpath)
autoload -U bashcompinit && bashcompinit
autoload -U compinit && compinit
complete -C aws_completer aws
complete -C aws_completer sudo
complete -C aws_completer aws-vault
complete -C $(which terragrunt) terragrunt
source ${HOMEBREW_PREFIX}/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc
source ${HOMEBREW_PREFIX}/opt/python-argcomplete/share/bash-completion/completions/python-argcomplete

# Nicer directory navigation
setopt autocd autopushd pushdignoredups

# Don't suggest ZSH typo corrections
unsetopt correct_all

# Allow comments in commands
setopt interactivecomments

# Clobber files with I/O redirection
set -o clobber

# Dedup PATH
export PATH=$(printf %s "$PATH" | awk -vRS=: '!a[$0]++' | paste -s -d: -)
export PATH=$(brew --prefix)/bin:$PATH
export PATH=$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH

export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export PATH="$PATH:/opt/homebrew/opt/mysql-client/bin"

# Created by `pipx` on 2022-09-07 16:08:59
export PATH="$PATH:/Users/mama/.local/bin"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

###-begin-cdk-completions-###
_cdk_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" cdk --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _cdk_yargs_completions cdk
compdef kubecolor=kubectl
###-end-cdk-completions-###
source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"

export PATH="$PATH:${HOME}/.local/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

. "$HOME/.local/bin/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/max/.lmstudio/bin"
# End of LM Studio CLI section
