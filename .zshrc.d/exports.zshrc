#!/usr/local/bin/zsh

if [ "$(uname)" = "Darwin" ]; then
  JAVA_HOME=$(/usr/libexec/java_home)
elif [ "$(uname)" = "Linux" ]; then
  JAVA_HOME="/usr/lib/jvm/java-12-oracle"
fi

export JAVA_HOME
export TERM="screen-256color"
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim

export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules --ignore venv --ignore .venv -g ""'

export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

GO_BIN_PATH="${HOME}/go/bin"
PIPX_PATH="${HOME}/.local/bin"
export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/bin:/usr/local/opt/imagemagick@6/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:${NPM_PATH}:$PATH"
export PATH="${PATH}:${GO_BIN_PATH}"
export PATH="${PATH}:${PIPX_PATH}"

eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(jenv init -)"

if hash gdircolors 2> /dev/null; then
  eval "$(gdircolors "${HOME}/.dircolors")"
fi

# shellcheck source=/dev/null
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export GROOVY_HOME=/usr/local/opt/groovy/libexec

export VIM_PY_PATH="$(brew --prefix python3)/bin/python3"
