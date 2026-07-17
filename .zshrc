# Deduplicate PATH entries
typeset -U path


###############################################################################
# zplug
###############################################################################
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
###############################################################################


###############################################################################
# includes
###############################################################################
HOMEBREW_PREFIX=/opt/homebrew
for f in ${HOME}/.zshrc.d/*.zshrc; do
  # shellcheck disable=SC1090
  source "${f}"
done
###############################################################################


###############################################################################
# completions
###############################################################################
fpath=(${HOME}/.zshrc.d/completions/ $fpath)
fpath=(${HOME}/.granted/zsh_autocomplete/assume/ $fpath)
fpath=(${HOME}/.granted/zsh_autocomplete/granted/ $fpath)

fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)

source ${HOMEBREW_PREFIX}/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc
source ${HOMEBREW_PREFIX}/opt/python-argcomplete/share/bash-completion/completions/python-argcomplete

autoload -U bashcompinit && bashcompinit
autoload -U compinit && compinit -C  # skip security audit — already run by zplug lib/compfix

complete -C aws_completer aws
complete -C "$(command -v terragrunt)" terragrunt

compdef kubecolor=kubectl
compdef -d git
###############################################################################


# Nicer directory navigation
setopt autocd autopushd pushdignoredups

# Don't suggest ZSH typo corrections
unsetopt correct_all

# Allow comments in commands
setopt interactivecomments

# Clobber files with I/O redirection
set -o clobber

# Cache eval outputs — regenerates only when the binary itself changes.
# Run `rm -rf ~/.cache/zsh` to force a full refresh.
_zsh_eval_cache() {
  local name=$1; shift
  local cache="${HOME}/.cache/zsh/${name}.zsh"
  local binary_path
  binary_path=$(command -v "$1" 2>/dev/null)
  if [[ ! -f "$cache" || ( -n "$binary_path" && "$binary_path" -nt "$cache" ) ]]; then
    mkdir -p "${cache:h}"
    "$@" > "$cache"
  fi
  [[ -f "$cache" ]] && source "$cache"
}

_zsh_eval_cache fzf     fzf --zsh
_zsh_eval_cache starship starship init zsh
_zsh_eval_cache atuin   atuin init zsh
_zsh_eval_cache zoxide  zoxide init zsh
_zsh_eval_cache logcli  logcli --completion-script-zsh
