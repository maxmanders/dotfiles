#!/usr/bin/env bash

################################################################################
# bootstrap
#
# Set up a new Mac with dotfiles and common software and utilities
################################################################################


log() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n[BOOTSTRAP] $fmt\\n" "$@"
}



################################################################################
# VARIABLES
################################################################################

osname=$(uname)

export COMMANDLINE_TOOLS="/Library/Developer/CommandLineTools"
export DOTFILES_DIR="${HOME}/code/src/github/maxmanders/dotfiles"

PS3="> "

computer_name=$(scutil --get ComputerName)
host_name=$(scutil --get LocalHostName)

if [ -z "${computer_name}" ] || [ -z "${host_name}" ]; then
  DEFAULT_COMPUTER_NAME="My Mac"
  DEFAULT_HOST_NAME="my-mac"
else
  DEFAULT_COMPUTER_NAME="${computer_name}"
  DEFAULT_HOST_NAME="${host_name}"
fi

TIME_ZONE="Europe/London"
DEFAULT_NODEJS_VERSION="12.18.3"
DEFAULT_RUBY_VERSION="3.0.3"
DEFAULT_PYTHON_VERSION="3.9.4"


################################################################################
# COMMAND LINE TOOLS
################################################################################

if [ ! -d "${COMMANDLINE_TOOLS}" ]; then
  log "Command line developer tools must be installed before
running this script. To install, run 'xcode-select --install' from
the terminal, and then follow the prompts. Once the command line
tools have been installed, you can run this script agian."
fi


# Make sure Rosetta 2 is installed
if [ $(arch) = "arm64" ]; then
  softwareupdate --install-rosetta --agree-to-license
fi


################################################################################
# Got Root
################################################################################

sudo -v

# maintain sudo until bootstrap complete
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

set -e


################################################################################
# Setup
################################################################################

printf "\\nEnter a name for your Mac. (Leave blank for default: %s)\\n" "$DEFAULT_COMPUTER_NAME"
read -r -p "> " COMPUTER_NAME
export COMPUTER_NAME=${COMPUTER_NAME:-$DEFAULT_COMPUTER_NAME}

printf "\\nEnter a host name for your Mac. (Leave blank for default: %s)\\n" "$DEFAULT_HOST_NAME"
read -r -p "> " HOST_NAME
export HOST_NAME=${HOST_NAME:-$DEFAULT_HOST_NAME}

DEFAULT_SHELL="zsh"

printf "\\nSelected options.\\n"
printf "Computer name:       ==> [%s]\\n" "$COMPUTER_NAME"
printf "Host name:           ==> [%s]\\n" "$HOST_NAME"
printf "Time zone:           ==> [%s]\\n" "$TIME_ZONE"
printf "Node.js version:     ==> [%s]\\n" "$DEFAULT_NODEJS_VERSION"
printf "Ruby version:        ==> [%s]\\n" "$DEFAULT_RUBY_VERSION"
printf "Python version:      ==> [%s]\\n" "$DEFAULT_PYTHON_VERSION"
printf "Default shell:       ==> [%s]\\n" "$DEFAULT_SHELL"

echo
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
  echo "Exiting..."
  exit 1
fi


################################################################################
# CLONE
################################################################################


################################################################################
# BOOTSTRAP
################################################################################

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "${HOME}/bin/" ]; then
  mkdir "${HOME}/bin"
fi

if [ $(arch) = "arm64" ]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "${LOGNAME}:admin" $HOMEBREW_PREFIX
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "${LOGNAME}:admin" "$HOMEBREW_PREFIX"
fi

update_zsh_shell() {
  local shell_path;
  shell_path="$(command -v zsh)"

  log "Changing shell to zsh ..."
  if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
    log "Adding '${shell_path}' to /etc/shells"
    sudo sh -c "echo ${shell_path} >> /etc/shells"
  fi
  sudo chsh -s "$shell_path" "$USER"
}

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

if ! command -v brew >/dev/null; then
  log "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ $(arch) = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

if brew list | grep -Fq brew-cask; then
  log "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

log "Updating Homebrew formulae ..."
# brew update --force # https://github.com/Homebrew/brew/issues/1151
brew bundle --file=Brewfile
if [ $(arch) = "arm64" ]; then
  arch -x86_64 brew bundle --file=Brewfile_x86_64
fi

$(brew --prefix python3)/bin/pip3 install neovim pynvim

update_zsh_shell

if [ ! -d "${HOME}/.pyenv/versions/${DEFAULT_PYTHON_VERSION}" ]; then
  log "Installing Python ${DEFAULT_PYTHON_VERSION}..."
  pyenv install "${DEFAULT_PYTHON_VERSION}"
fi

sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$HOST_NAME"
sudo scutil --set LocalHostName "$HOST_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$HOST_NAME"

home_files=(
.ctags
.dircolors
.git_template
.gitconfig-dist
.gitignore
.p10k.zsh
.psqlrc
.screenrc
.tmux.conf
.travis.yml
.vimrc
.zshrc
.zshrc.d
init.vim
)

nvim_files=(
init.vim
)

log "Installing dotfiles..."

for item in "${home_files[@]}"; do
  if [ -e "${HOME}/${item}" ]; then
    log "${item} exists."
    if [ -L "${HOME}/${item}" ]; then
      log "Symbolic link detected. Removing..."
      rm -v "${HOME}/${item}"
    fi
  fi
  log "-> Linking ${PWD}/${item} to ${HOME}/${item}..."
  ln -nfs "${PWD}/${item}" "${HOME}/${item}"
done

mkdir -p "${HOME}/.config/nvim"

log "Installing neovim config..."

for item in "${nvim_files[@]}"; do
  if [ -e "${HOME}/.config/nvim/${item}" ]; then
    log "${item} exists."
    if [ -L "${HOME}/.config/nvim/${item}" ]; then
      log "Symbolic link detected. Removing..."
      rm -v "${HOME}/.config/nvim/${item}"
    fi
  fi
  log "-> Linking ${PWD}/${item} to ${HOME}/.config/nvim/${item}..."
  ln -nfs "${PWD}/${item}" "${HOME}/.config/nvim/${item}"
done

log "Installing tmux plugin manager"
rm -fr "${HOME}/.tmux"
git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"

if [ ! -d "${HOME}/.zplug" ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [ ! -f "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

log "Dotfiles installation complete!"

log "Post-install recommendations:"
log "- Complete Brew Bundle installation with 'brew bundle install'"
log "- After launching Neovim, run :checkhealth and resolve any errors/warnings."
