# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ${HOME}/.zplug/init.zsh

zplug "mafredri/zsh-async", from:"github"
zplug "sindresorhus/pure", use:"pure.zsh", from:"github", as:"theme"
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

for file in ${HOME}/.zshrc.d/*.zshrc; do
  # shellcheck disable=SC1090
  source "${file}"
done

# shellcheck source=/dev/null
fpath=(${HOME}/.zshrc.d/completions/ $fpath)
HOMEBREW_PREFIX="$(brew --prefix)"
fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
autoload -U bashcompinit && bashcompinit
autoload -U compinit && compinit
complete -C aws_completer aws
complete -C aws_completer sudo
complete -C aws_completer aws-vault
source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/opt/openssl@3/bin:$PATH"


if [[ "$(arch)" == "arm64" ]]; then
  source /opt/homebrew/opt/asdf/libexec/asdf.sh
  export PATH="$PATH:/opt/homebrew/opt/mysql-client/bin"
else
  source /usr/local/opt/asdf/libexec/asdf.sh
  export PATH="$PATH:/usr/local/homebrew/opt/mysql-client/bin"
fi



# Created by `pipx` on 2022-09-07 16:08:59
export PATH="$PATH:/Users/mama/.local/bin"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/mama/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
###-end-cdk-completions-###
eval "$(atuin init zsh)"
