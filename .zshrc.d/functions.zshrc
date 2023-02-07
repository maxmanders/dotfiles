#!/usr/local/bin/zsh

################################################################################
# Check if a binary exists, and report an error if it can't be found
# term.
# Arguments:
#   $1: a binary to check for
# Returns:
#   None
################################################################################
function check_bin() {
  bin="${1}"

  # shellcheck disable=SC2154
  command -v "${bin}" >/dev/null 2>&1 || \
    print -P "%{$FG[196]%}'${bin}' not installed%{$reset_color%}"
}

################################################################################
# Check dependencies
################################################################################
check_bin ag
check_bin aws
check_bin column
check_bin curl
check_bin dig
check_bin git
check_bin jq
check_bin mktemp
check_bin paste
check_bin python
check_bin sed
check_bin tmux
check_bin tree
check_bin wget

################################################################################
# Searches history for $1 and outputs those commands that match the search
# term.
# Arguments:
#   $1: a term to search history for
# Returns:
#   None
################################################################################
function hgrep() {
  string="${*}"
  history | ag -i "${string}"
}

################################################################################
# Search for EC2 instances with a name tag containing $1, and print a row for
# each result with the following columns: InstanceId, PrivateIpAddress, Name.
# Arguments:
#   $1: a name tag to search for
# Returns:
#   None
################################################################################
function instances_by_name() {
  aws ec2 describe-instances --filter "Name=tag:Name,Values=*${1}*" | \
  jq ".Reservations[].Instances[] | \
  .InstanceId, \
  .PrivateIpAddress, \
  (.Tags[] | select(.Key == \"Name\") | \
      .Value)" | \
    sed 's/"//g' | \
    paste - - -
}

################################################################################
# Prints out useful information about an EC2 instance, given an InstanceId.
# Arguments:
#   $1: an InstanceId to search for
# Returns:
#   None
################################################################################
function i() {
  aws ec2 describe-instances --instance-id "${1}" | \
  jq -r ".Reservations[].Instances[] | \
      \"InstanceId: \(.InstanceId)\", \
      \"IP Address: \(.PrivateIpAddress)\", \
        (.Tags[] | \"\(.Key): \(.Value)\")"
}

################################################################################
# Prints out the endpoint for the given RDS InstanceIdentifier, or all
# for all InstanceIdentifiers if none is given
# arguments:
#   $1: an instanceidentifier to search for
# returns:
#   none
################################################################################
function rds_instances() {
  param=""
  if [ $# -eq 1 ]; then
    param="--db-instance-identifier ${1}"
  fi
  cmd="aws rds describe-db-instances ${param}"

  eval "${cmd}" | \
  jq ".DBInstances[] | \
      .DBInstanceIdentifier, \
      .Endpoint.Address" | \
  sed 's/"//g' | \
  paste - - | \
  column -t
}

################################################################################
# Prints out the description of an elasticache replication group, given
# a replication group identifier
# arguments:
#   $1: a replicationgroup identifier
# returns:
#   none
################################################################################
function ecwat() {
  aws elasticache describe-replication-groups --replication-group-id "${1}" \
      --query "ReplicationGroups[].Description"
}

################################################################################
# search `git ls-files`
# arguments:
#   $1: a term to search for
# returns:
#   none
################################################################################
function gfind() {
  git ls-files | ag -i "${1}"
}

################################################################################
# prints out your public ip.
# arguments:
#   none
# returns:
#   none
################################################################################
function getip() {
  curl -s https://ident.me
}

################################################################################
# prints out your public ip.
# arguments:
#   none
# returns:
#   none
################################################################################
function getlocalip() {
  if [[ "$(uname)" == 'Darwin' ]]; then
    networksetup -getinfo wi-fi | awk '/^IP address/'
  fi
}

################################################################################
# ssh as root to an ec2 instance by ip
# arguments:
#   none
# returns:
#   none
################################################################################
function ssh_instance() {
  address=$(aws ec2 describe-instances --instance-ids "${1}" | \
  jq -r '.reservations[].instances[].networkinterfaces[].privateipaddress')

  ssh "root@${address}"
}

################################################################################
# return to puppet _production_ branch, pull, and delete feature branch
# arguments:
#   none
# returns:
#   none
################################################################################
function brdone() {
  to_delete=$(git rev-parse --abbrev-ref head)
  git co production && git br -d "${to_delete}" && gup && unset to_delete
}

function makesetup() {
  # shellcheck disable=SC1091
  source .venv/bin/activate

  DEV_STACK_NAME="${1}" \
    WAIT_FOR_SETTLED=1 \
    OVERRIDE_SERVICE_TIMEOUTS=600 \
    DEVSTACK_SSH_OPTIONS="-o ControlPath=no" \
    DEVSTACK_SCP_OPTIONS="-o ControlPath=no" \
    make setup

  deactivate
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~ The following functions courtesy of Jess Frazelle
#~ https://github.com/jessfraz/dotfiles
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

################################################################################
# Create a directory and cd to it
# arguments:
#   $1: the name of the directory to create
# returns:
#   none
################################################################################
function mkd() {
  mkdir -p "$@"
  cd "$@" || exit
}

################################################################################
# Create a tmp directory and cd to it
# arguments:
#   $1: the name of the directory to create
# returns:
#   none
################################################################################
function tmpd() {
  local dir
  if [ $# -eq 0 ]; then
    dir=$(mktemp -d)
  else
    dir=$(mktemp -d -t "${1}.XXXXXXXXXX")
  fi
  cd "$dir" || exit
}

################################################################################
# Create a git.io short link
# arguments:
#   $1: the slug to use
#   $2: the URL to use
# returns:
#   none
################################################################################
function gitio() {
  if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "Usage: \`gitio slug url\`"
    return 1
  fi
  curl -i https://git.io/ -F "url=${2}" -F "code=${1}"
}

################################################################################
# Pretty print JSON
# arguments:
#   $1: the JSON to print (or pipe)
# returns: #   none
################################################################################
function json() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript
  else # pipe
    python -mjson.tool | pygmentize -l javascript
  fi
}

################################################################################
# Print useful information about a domain
# arguments:
#   $1: the domain to check
# returns:
#   none
################################################################################
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

################################################################################
# Colourised `tree` with hidden files, excluding git
# arguments:
#   $1: a list of locations
# returns:
#   none
################################################################################
function tre() {
  tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

################################################################################
# Call from a local repo to open the repository on github/bitbucket in browser
# Modified version of https://github.com/zeke/ghwd
# arguments:
#   none
# returns:
#   none
################################################################################
function repo() {
  # Figure out github repo base URL
  local base_url
  base_url=$(git config --get remote.origin.url)
  base_url=${base_url%\.git} # remove .git from end of string

  # Fix git@github.com: URLs
  base_url=${base_url//git@github\.com:/https:\/\/github\.com\/}

  # Fix git://github.com URLS
  base_url=${base_url//git:\/\/github\.com/https:\/\/github\.com\/}

  # Fix git@bitbucket.org: URLs
  base_url=${base_url//git@bitbucket.org:/https:\/\/bitbucket\.org\/}

  # Fix git@gitlab.com: URLs
  base_url=${base_url//git@gitlab\.com:/https:\/\/gitlab\.com\/}

  # Validate that this folder is a git folder
  if ! git branch 2>/dev/null 1>&2 ; then
    echo "Not a git repo!"
    exit $?
  fi

  # Find current directory relative to .git parent
  full_path=$(pwd)
  git_base_path=$(cd "./$(git rev-parse --show-cdup)" || exit 1; pwd)
  relative_path=${full_path#$git_base_path} # remove leading git_base_path from working directory

  # If filename argument is present, append it
  if [ "$1" ]; then
    relative_path="$relative_path/$1"
  fi

  # Figure out current git branch
  # git_where=$(command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
  git_where=$(command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null

  # Remove cruft from branchname
  branch=${git_where#refs\/heads\/}

  [[ $base_url == *bitbucket* ]] && tree="src" || tree="tree"
  url="$base_url/$tree/$branch$relative_path"


  echo "Calling $(type open) for $url"

  open "$url" &> /dev/null || (echo "Using $(type open) to open URL failed." && exit 1);
}

gshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always %'" \
             --bind "enter:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

list_devstacks() {
  aws ec2 describe-instances \
    --filters Name=tag:Project,Values=DevStacks \
    --query "Reservations[].Instances[].[[InstanceId, Tags[?Key==\`Name\`].Value][]][].{InstanceId: [0], Name: [1]}" \
    | jq 'sort_by(.Name) | .[]'
}

list_production_instances() {
  aws ec2 describe-instances \
    --filters Name=tag:Environment,Values=Production \
    --query "Reservations[].Instances[?!not_null(Tags[?Key==\`aws:autoscaling:groupName\`].Value) && !not_null(Tags[?Key==\`aws:elasticmapreduce:instance-group-role\`].Value)][].[[InstanceId, Tags[?Key==\`Name\`].Value][]][].{InstanceId: [0], Name: [1]}" \
    | jq 'sort_by(.Name) | .[]'
}

get_ec2_ip() {
  aws ec2 describe-instances --instance-ids $1 \
    --query "Reservations[*].Instances[*].PrivateIpAddress" \
    --output=text
}

rmd() {
  local srcfile
  srcfile="${1}"
  pandoc -f gfm "${srcfile}" | lynx -stdin
}

togif() {
  local infile
  local base_name
  local outfile

  infile="${1}"
  base_name="${infile%.*}"
  outfile="${base_name}.gif"
  

  ffmpeg -i "${infile}" -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "${outfile}"
}

randpw() {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16}
  echo
}

ghash() {
  git rev-parse --short head
}

repocd() {
  local query

  query="${1}"

  if [ -z "${query}" ]; then
    cd $(fd --hidden --type d --glob ".git" ~/code/src/github.com --exec dirname | fzf)
  else
    cd $(fd --hidden --type d --glob ".git" ~/code/src/github.com --exec dirname | ag ${query} | fzf)
  fi
}

# List all AWS actions for a given service
# Courtesy of Thomas-Franklin
aws_services_to_actions() {
  curl --header 'Connection: keep-alive' \
     --header 'Pragma: no-cache' \
     --header 'Cache-Control: no-cache' \
     --header 'Accept: */*' \
     --header 'Referer: https://awspolicygen.s3.amazonaws.com/policygen.html' \
     --header 'Accept-Language: en-US,en;q=0.9' \
     --silent \
     --compressed \
     'https://awspolicygen.s3.amazonaws.com/js/policies.js' |
    cut -d= -f2 |
    jq -r '.serviceMap[] | .StringPrefix as $prefix | .Actions[] | "\($prefix):\(.)" | select(. | test($v))' --arg v "${1:-^\w:*}" |
    sort |
    uniq
}

docker_tidy() {
	docker ps -a | sed 1d | awk '{print $1}' | xargs -I {} docker rm {}
}

gh2azure() {
  local gh_user="${1}"
  local org="${2}"
  local url="https://api.github.com/graphql"
  local query="query { user(login: \\\"${gh_user}\\\"){organizationVerifiedDomainEmails(login: \\\"${org}\\\")}}"

  curl --request POST --silent "${url}" \
  --header "Authorization: token ${GITHUB_TOKEN}" \
  --header "content-type: application/json" \
  -d "{\"query\": \"${query}\"}" \
  | jq --raw-output '.data.user.organizationVerifiedDomainEmails[0]'
}
