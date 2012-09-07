# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow debian dircycle screen svn python django)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/max/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/bin:/home/max/bin

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

export TERM="xterm-256color"
export GREP_COLOR='2;36'

alias svnd='svn diff --diff-cmd diff -x -wu'
alias :e='vim'
alias gopen='gnome-open'
alias fsvn='find . -path "*/.svn*" -prune -o -print'

stty -ixon

#eval $(dircolors ~/.dircolors.ansi-dark)

function set_dark()
{
  ${HOME}/bin/gnome-terminal-colors-solarized/set_dark.sh
  eval $(dircolors ${HOME}/bin/dircolors-solarized/dircolors.ansi-dark)
}

function set_light()
{
  ${HOME}/bin/gnome-terminal-colors-solarized/set_light.sh
  eval $(dircolors ${HOME}/bin/dircolors-solarized/dircolors.ansi-light)
}

case "/$(ps -p $PPID -o comm=)" in
  */sshd) exec screen -R -d zsh;;
esac

export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
