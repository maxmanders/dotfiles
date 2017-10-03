#!/usr/local/bin/zsh

_apex()  {
  COMPREPLY=()
  local cur
  local opts
  cur="${COMP_WORDS[COMP_CWORD]}"
  #shellcheck disable=SC2068
  opts="$(apex autocomplete -- ${COMP_WORDS[@]:1})"
  COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
  return 0
}

complete -F _apex apex
