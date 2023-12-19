up() {
  local parents=${1:-1}
  if ! [[ "$parents" -gt 0 ]]; then
    echo >&2 "up: expecting numeric argument: number of parent dirs"
    return 1
  fi
  local -a dotdots=($(printf "..%.0s\n" {1..$parents}))
  local cdstr="${(pj:/:)dotdots}"
  cd $cdstr
}
