#!/usr/local/bin/zsh

mkd() {
  mkdir -p "$@"
  cd "$@" || exit
}

ghash() {
  git rev-parse --short head
}

repocd() {
  local query

  query="${1}"

  src_dir="${HOME}/code/src/github"
  if [ ! -d "${src_dir}" ]; then
    src_dir="${HOME}/code/src/github.com"
  fi


  repo_dirs=$(\
    bkt --ttl 60m --stale 30m -- \
      fd --no-ignore --hidden --type d --glob ".git" \
      "${src_dir}" --exec dirname \
  )

  if [ -z "${query}" ]; then
    cd "$(echo "${repo_dirs}" | fzf)" || false
  else
    cd "$(echo "${repo_dirs}" | ag "${query}" | fzf)" || false
  fi
}

function gdef() {

  default_branch="$(\
    git remote show origin \
    | sed -n '/HEAD branch/s/.*: //p' \
  )"

  current_branch="$(git rev-parse --abbrev-ref HEAD)"

  git checkout "${default_branch}"
  git fetch origin
  git pull origin "${default_branch}"
  if [ "${default_branch}" != "${current_branch}" ]; then
    git branch --delete "${current_branch}"
  fi

  git remote prune origin
}

function defang() {
  case "$1" in
    "-r") echo "$2" | sed 's/hxxp/http/g' | sed 's/\[:\/\/\]/:\/\//g' | sed 's/\[\.\]/\./g' | tee >(pbcopy) ;;
    *) echo "$1" | sed 's/http/hxxp/g' | sed 's/:\/\//\[:\/\/\]/g' | sed 's/\./[\.]/g' | tee >(pbcopy) ;;
  esac
}

function brewdump() {
  brewfile_realpath="$(realpath "${HOME}/Brewfile")"

  brew bundle dump --force --file "${brewfile_realpath}" 2> >(grep -v "exec: asdf: not found" >&2)
  sed -i '' '/^mas /d' "${brewfile_realpath}"
  sed -i '' '/^go /d' "${brewfile_realpath}"
  sed -i '' '/^uv /d' "${brewfile_realpath}"
}

create-volume-snapshot() {
  local pvc_name
  local namespace
  local snapshot_name

  pvc_name="${1}"
  namespace="${2}"
  snapshot_name="${3}"

  if [[ -z "${pvc_name}" || -z "${namespace}" || -z "${snapshot_name}" ]]; then
    echo "Usage: create_volume_snapshot <pvc_name> <namespace> <snapshot_name>"
    return 1
  fi

  cat <<EOF | kubectl apply -f -
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshot
metadata:
  name: ${snapshot_name}
  namespace: ${namespace}
spec:
  volumeSnapshotClassName: csi-aws-ebs-delete-vsc
  source:
    persistentVolumeClaimName: ${pvc_name}
EOF

  echo "VolumeSnapshot '${snapshot_name}' for PVC '${pvc_name}' in namespace '${namespace}' created."
}

function _kube_list_pods() {
  kubectl get pods --all-namespaces \
    --output go-template='{{range .items}}{{.metadata.name}}:{{.metadata.namespace}}:{{.status.phase}}{{"\n"}}{{end}}' \
  | sort -k 2 -k 1 -t:
}

function podshell () {
    local cmd pod pod_name namespace containers container

    cmd="${1}"
    pod=$(_kube_list_pods | fzf --prompt="Select pod: ")
    pod_name=$(echo "${pod}" | cut -d: -f1)
    namespace=$(echo "${pod}" | cut -d: -f2)

    # Get containers for the selected pod
    containers=$(kubectl --namespace "${namespace}" get pod "${pod_name}" \
        -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n')

    # If more than one container, prompt for selection
    container_count=$(echo "${containers}" | wc -l | tr -d ' ')
    if [[ "${container_count}" -gt 1 ]]; then
        container=$(echo "${containers}" | fzf --prompt="Select container: ")
    else
        container="${containers}"
    fi

    kubectl --namespace "${namespace}" exec -it "${pod_name}" \
        -c "${container}" -- "${cmd:-bash}"
}

tfclean() {
  \find . \
  -type d -name '.terragrunt-cache' -prune -exec rm -rf {} + \
  -o -type f -name '.terraform.lock.hcl' -delete
}

prs-by-day() {
  local today opened closed

  today="${1}"

  if [ -z "${today}" ]; then
    today="$(date +%F)"
  fi

  opened="$(gh search prs --author=@me --created="$today" --limit 100 --json url,title)"
  closed="$(gh search prs --author=@me --closed="$today"  --limit 100 --json url,title)"

  jq -rn --argjson opened "$opened" --argjson closed "$closed" '
    ($opened | map({url, title, opened: true}))
    + ($closed | map({url, title, closed: true}))
    | group_by(.url)
    | map(
        .[0] as $f
        | {
            url:    $f.url,
            title:  $f.title,
            opened: (map(.opened) | any),
            closed: (map(.closed) | any)
          }
      )
    | sort_by(.url)
    | (
        ["| Status | PR | Title |",
         "| --- | --- | --- |"]
        + (
          map(
            ([ (if .opened then "opened" else empty end),
               (if .closed then "closed" else empty end) ] | join("+")) as $status
            | ( .url | capture("github\\.com/(?<r>[^/]+/[^/]+)/pull/(?<n>[0-9]+)")
                    | "\(.r)#\(.n)" ) as $pr
            | ( .title | gsub("\\|"; "\\|") ) as $title
            | "| \($status) | \($pr) | \($title) |"
          )
        )
      )
    | .[]
  '
}

# tmux session manager
tm() {
  emulate -L zsh
  setopt local_options pipe_fail

  # --- 1. Pick a directory -------------------------------------------------
  local dir
  local src_dir
  src_dir="${HOME}/code/src/github"
  dir=$(fd --type d --hidden --glob ".git" "${src_dir}" 2>/dev/null --exec dirname | fzf) || false

  [[ -z "${dir}" ]] && return 0
  dir="${dir:A}"
  [[ -d "${dir}" ]] || { print -ru2 "tm: not a directory: ${dir}"; return 1 }

  # --- 2. tmux-safe session name (strip '.' and ':' target separators) -----
  local name="${${dir:t}//[.:]/_}"

  # --- 3. Build the session only if it doesn't already exist ---------------
  if ! tmux has-session -t="${name}" 2>/dev/null; then
    tmux new-session -d -s "${name}" -c "${dir}" -n main
    tmux send-keys -t "${name}:main" 'nvim' C-m

    pane_0="$(tmux display-message -t "${name}:main" -p '#{pane_id}')"
    pane_1="$(tmux split-window -t "${name}:main" -h -l '35%' -c "${dir}" -P -F '#{pane_id}')"
    pane_2="$(tmux split-window -t "${pane_1}" -v -l '50%' -c "${dir}")"
  fi

  # --- 4. Enter the session ------------------------------------------------
  if [[ -n "${TMUX}" ]]; then
    tmux switch-client -t "${name}"
  else
    tmux attach-session -t "${name}"
  fi
}

# kill tmux sessions interactively
tk() {
  tmux list-sessions -F '#{session_name}' | fzf --multi | while read -r s; do
    tmux kill-session -t "${s}"
  done
}
