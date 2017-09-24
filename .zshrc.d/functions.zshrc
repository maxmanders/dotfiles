#!/usr/local/bin/zsh

################################################################################
# Check dependencies
################################################################################
check_bin ag
check_bin aws

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

  command -v "${bin}" >/dev/null 2>&1 || \
    print -P "%{$FG[196]%}'${bin}' not installed%{$reset_color%}"
}

################################################################################
# Searches history for $1 and outputs those commands that match the search
# term.
# Arguments:
#   $1: a term to search history for
# Returns:
#   None
################################################################################
function hgrep() {
  string=$@
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
  aws ec2 describe-instances --instance-id ${1} | \
  jq -r ".Reservations[].Instances[] | \
            \"InstanceId: \(.InstanceId)\", \
            \"IP Address: \(.PrivateIpAddress)\", \
              (.Tags[] | \"\(.Key): \(.Value)\")"
}

################################################################################
# Prints out the EC2 InstanceIds and PrivateIPAddresses for all instances in
# the given Auto-Scaling Group.
# Arguments:
#   $1: an Auto-Scaling Group name to search for
# Returns:
#   None
################################################################################
function asg_instances() {
  aws ec2 describe-instances --instance-ids $(
  aws autoscaling describe-auto-scaling-groups \
      --auto-scaling-group-name ${1} | \
      jq ".AutoScalingGroups[].Instances[] | .InstanceId" | \
        sed 's/"//g' | \
        paste -) | \
      jq ".Reservations[].Instances[] | \
          .InstanceId, \
          .PrivateIpAddress" | \
      sed 's/"//g' | \
      paste - -
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

  eval ${cmd} | \
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
  aws elasticache describe-replication-groups --replication-group-id $1 \
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
  git ls-files | ag -i $1
}

################################################################################
# prints out your public ip.
# arguments:
#   none
# returns:
#   none
################################################################################
function getip() {
  wget -qo- checkip.amazonaws.com
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
  address=$(aws ec2 describe-instances --instance-ids $1 | \
  jq -r '.reservations[].instances[].networkinterfaces[].privateipaddress')

  ssh root@${address}
}

################################################################################
# ssh wrapper to rename tmux window title with the connected hostname.
# arguments:
#   none
# returns:
#   none
################################################################################
function ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
      tmux rename-window "$(echo $* | cut -d . -f 1)"
      command ssh "$@"
      tmux set-window-option automatic-rename "on" 1>/dev/null
  else
      command ssh "$@"
  fi
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
