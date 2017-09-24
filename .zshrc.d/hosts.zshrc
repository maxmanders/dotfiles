#!/usr/local/bin/zsh

load_hosts() {
  if [[ -r ~/.ssh/known_hosts ]]
  then
      # shellcheck disable=SC2086
      _known_hosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
  fi
  # shellcheck disable=SC1001
  _known_hosts+=("${(f)$(r53grep -d | \grep -E 'IN\s(A|CNAME)' | awk '{print substr($1, 0, length($1)-1)}')}")
  zstyle ':completion:*:hosts' hosts "${_known_hosts[@]}"
}
load_hosts
