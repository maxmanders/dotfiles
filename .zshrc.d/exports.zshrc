#!/usr/local/bin/zsh

export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export GOBIN=$GOPATH/bin

# export PATH="$PATH:$HOME:/.rbenv/shims:$HOME/.rbenv/bin"
# export PATH="$PATH:$HOME/.pyenv/shims"
export PATH="$PATH:$HOME:/bin"
export PATH="$PATH:/opt/local/bin:/opt/local/sbin"
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin"
export PATH="$PATH:$GOPATH"
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin"
export PATH="$PATH:/usr/local/opt"


# export JAVA_HOME=$(/usr/libexec/java_home)
export TERM="screen-256color"
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim

export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules --ignore venv --ignore .venv -g ""'

export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export PIPX_PATH="${HOME}/.local/bin"

# eval "$(rbenv init - --no-rehash)"
# eval "$(pyenv init --path)"
# eval "$(jenv init - --no-rehash)"

if hash gdircolors 2> /dev/null; then
  eval "$(gdircolors "${HOME}/.dircolors")"
fi

# shellcheck source=/dev/null
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export GROOVY_HOME=/usr/local/opt/groovy/libexec

export VIM_PY_PATH="$(brew --prefix python3)/bin/python3"

export AWS_PAGER=


export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$(brew --prefix)/share/zsh-syntax-highlighting/highlighters
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '
