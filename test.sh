#!/bin/bash
set -e
set -o pipefail

ZSH=$(which zsh)
BASH=$(which bash)

ERRORS=()

# find all shebang files
for f in $(
  find . -path ./.oh-my-zsh -prune -o \
         -path ./bin -prune -o \
         -type f -not -iwholename '*.git*' \
         -exec awk '/^#!\//{print FILENAME} {nextfile}' {} + | sort -u); do

  # shellcheck disable=SC1001
  if file "$f" | \grep -E --quiet "shell|zsh"; then
    {
      shellcheck <(sed "s|#\\!${ZSH}|#\\!${BASH}|g" < "${f}") && echo "  [ok]: linted ${f}"
    }\
      ||\
    {
      ERRORS+=("${f}")
    }
  fi

done

if [ ${#ERRORS[@]} -ne 0 ]; then
	echo "[fail]: these files failed shellcheck: ${ERRORS[*]}"
	exit 1
fi
