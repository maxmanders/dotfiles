#!/usr/local/bin/zsh

# Ctrl-X,e: Open the current command line in $EDITOR
bindkey '^Xe' edit-command-line

# Ctrl-U: Kill from cursor to start of line
bindkey '^U' backward-kill-line

# Ctrl-Y: Yank killed lines back to the command line
bindkey '^Y' yank
