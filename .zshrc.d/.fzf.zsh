# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/max/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/max/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/max/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/max/.fzf/shell/key-bindings.zsh"
