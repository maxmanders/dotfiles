# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="bira"

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
plugins=(brew github git git-flow dircycle python django osx pip vagrant virtualenvwrapper knife ruby rails gem zsh-syntax-highlighting heroku)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

export TERM="xterm-256color"
export GREP_COLOR='2;36'

alias svnd='svn diff --diff-cmd diff -x -wu'
alias :e='vim'
alias gopen='gnome-open'
alias fsvn='find . -path "*/.svn*" -prune -o -print'
alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"
alias h="history"

# virtualenv aliases
alias v='workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'

alias serve='python -m SimpleHTTPServer'

stty -ixon

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

kernel=`uname -s`
case $kernel in
    Darwin)
        export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
    ;;
    Linux)
        eval $(dircolors ~/.dircolors.ansi-dark)
    ;;
    *) ;;
esac

#autoload

_bash_complete() {
  local ret=1
  local -a suf matches
  local COMP_POINT COMP_CWORD
  local -a COMP_WORDS COMPREPLY BASH_VERSINFO
  local COMP_LINE="$words"
  local -A savejobstates savejobtexts

  (( COMP_POINT = 1 + ${#${(j. .)words[1,CURRENT]}} + $#QIPREFIX + $#IPREFIX + $#PREFIX ))
  (( COMP_CWORD = CURRENT - 1))
  COMP_WORDS=( $words )
  BASH_VERSINFO=( 2 05b 0 1 release )
  export COMP_POINT
  export COMP_LINE

  savejobstates=( ${(kv)jobstates} )
  savejobtexts=( ${(kv)jobtexts} )

  [[ ${argv[${argv[(I)nospace]:-0}-1]} = -o ]] && suf=( -S '' )

  matches=( ${(f)"$(compgen $@ -- ${words[CURRENT]})"} )

  if [[ -n $matches ]]; then
    if [[ ${argv[${argv[(I)filenames]:-0}-1]} = -o ]]; then
      compset -P '*/' && matches=( ${matches##*/} )
      compset -S '/*' && matches=( ${matches%%/*} )
      compadd -Q -f "${suf[@]}" -a matches && ret=0
    else
      compadd -Q "${suf[@]}" -a matches && ret=0
    fi
  fi

  if (( ret )); then
    if [[ ${argv[${argv[(I)default]:-0}-1]} = -o ]]; then
      _default "${suf[@]}" && ret=0
    elif [[ ${argv[${argv[(I)dirnames]:-0}-1]} = -o ]]; then
      _directories "${suf[@]}" && ret=0
    fi
  fi

  return ret
}

compgen() {
  local opts prefix suffix job OPTARG OPTIND ret=1
  local -a name res results jids
  local -A shortopts

  # words changes behavior: words[1] -> words[0]
  emulate -L sh
  setopt kshglob noshglob braceexpand nokshautoload

  shortopts=(
    a alias b builtin c command d directory e export f file
    g group j job k keyword u user v variable
  )

  while getopts "o:A:G:C:F:P:S:W:X:abcdefgjkuv" name; do
    case $name in
      [abcdefgjkuv]) OPTARG="${shortopts[$name]}" ;&
      A)
        case $OPTARG in
      alias) results+=( "${(k)aliases[@]}" ) ;;
      arrayvar) results+=( "${(k@)parameters[(R)array*]}" ) ;;
      binding) results+=( "${(k)widgets[@]}" ) ;;
      builtin) results+=( "${(k)builtins[@]}" "${(k)dis_builtins[@]}" ) ;;
      command)
        results+=(
          "${(k)commands[@]}" "${(k)aliases[@]}" "${(k)builtins[@]}"
          "${(k)functions[@]}" "${(k)reswords[@]}"
        )
      ;;
      directory)
        setopt bareglobqual
        results+=( ${IPREFIX}${PREFIX}*${SUFFIX}${ISUFFIX}(N-/) )
        setopt nobareglobqual
      ;;
      disabled) results+=( "${(k)dis_builtins[@]}" ) ;;
      enabled) results+=( "${(k)builtins[@]}" ) ;;
      export) results+=( "${(k)parameters[(R)*export*]}" ) ;;
      file)
        setopt bareglobqual
        results+=( ${IPREFIX}${PREFIX}*${SUFFIX}${ISUFFIX}(N) )
        setopt nobareglobqual
      ;;
      function) results+=( "${(k)functions[@]}" ) ;;
      group)
        emulate zsh
        _groups -U -O res
        emulate sh
        setopt kshglob noshglob braceexpand
        results+=( "${res[@]}" )
      ;;
      hostname)
        emulate zsh
        _hosts -U -O res
        emulate sh
        setopt kshglob noshglob braceexpand
        results+=( "${res[@]}" )
      ;;
      job) results+=( "${savejobtexts[@]%% *}" );;
      keyword) results+=( "${(k)reswords[@]}" ) ;;
      running)
        jids=( "${(@k)savejobstates[(R)running*]}" )
        for job in "${jids[@]}"; do
          results+=( ${savejobtexts[$job]%% *} )
        done
      ;;
      stopped)
        jids=( "${(@k)savejobstates[(R)suspended*]}" )
        for job in "${jids[@]}"; do
          results+=( ${savejobtexts[$job]%% *} )
        done
      ;;
      setopt|shopt) results+=( "${(k)options[@]}" ) ;;
      signal) results+=( "SIG${^signals[@]}" ) ;;
      user) results+=( "${(k)userdirs[@]}" ) ;;
          variable) results+=( "${(k)parameters[@]}" ) ;;
      helptopic) ;;
    esac
      ;;
      F)
        COMPREPLY=()
        local -a args
        args=( "${words[0]}" "${@[-1]}" "${words[CURRENT-2]}" )
        (){
          # There may be more things we need to add to this typeset to
          # protect bash functions from compsys special variable names
          typeset -h words
          $OPTARG "${args[@]}"
        }
    results+=( "${COMPREPLY[@]}" )
      ;;
      G)
        setopt nullglob
        results+=( ${~OPTARG} )
    unsetopt nullglob
      ;;
      W) results+=( ${(Q)~=OPTARG} ) ;;
      C) results+=( $(eval $OPTARG) ) ;;
      P) prefix="$OPTARG" ;;
      S) suffix="$OPTARG" ;;
      X)
        if [[ ${OPTARG[0]} = '!' ]]; then
      results=( "${(M)results[@]:#${OPTARG#?}}" )
    else
      results=( "${results[@]:#$OPTARG}" )
    fi
      ;;
    esac
  done
  
  # support for the last, `word' option to compgen. Zsh's matching does a
  # better job but if you need to, comment this in and use compadd -U
  # (( $# >= OPTIND)) && results=( "${(M)results[@]:#${@[-1]}*}" )

  print -l -r -- "$prefix${^results[@]}$suffix"
}

complete() {
  emulate -L zsh
  local args void cmd print remove
  args=( "$@" )
  zparseopts -D -a void o: A: G: W: C: F: P: S: X: a b c d e f g j k u v \
      p=print r=remove
  if [[ -n $print ]]; then
    printf 'complete %2$s %1$s\n' "${(@kv)_comps[(R)_bash*]#* }"
  elif [[ -n $remove ]]; then
    for cmd; do
      unset "_comps[$cmd]"
    done
  else
    compdef _bash_complete\ ${(j. .)${(q)args[1,-1-$#]}} "$@"
  fi
}


# AWS Settings
export AWS_CONFIG_FILE=${HOME}/.awsconfig
compinit
autoload -Uz bashcompinit
complete -C aws_completer aws

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

unsetopt correct_all

export PATH=$PATH:$HOME/bin:/opt/local/bin:/opt/local/sbin

PATH=$PATH:/usr/local/rvm/bin # Add RVM to PATH for scripting

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

cookwith() {
    local chef_env=$1
    export CHEF_ENV=${chef_env}
}
