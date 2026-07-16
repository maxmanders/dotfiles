#!/usr/bin/env zsh

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:${HOMEBREW_PREFIX}/bin"
export PATH="$PATH:${HOMEBREW_PREFIX}/sbin"
export PATH="$PATH:${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/local/bin"

export AWS_PAGER=

export EDITOR=nvim

export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules --ignore venv --ignore .venv -g ""'

export GIT_EDITOR=nvim

LESSPIPE="$(command -v src-hilite-lesspipe.sh)"
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '
source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export MANPATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnuman:$MANPATH"

export PIPX_PATH="${HOME}/.local/bin"

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/highlighters

if hash gdircolors 2> /dev/null; then
  test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
fi
