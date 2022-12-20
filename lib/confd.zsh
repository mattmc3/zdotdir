export ZSHRCD=${ZSHRCD:-${ZDOTDIR:-~/.config/zsh}/conf.d}

function source-dir {
  [[ -d "$1" ]] || return 1
  local f
  for f in "$1"/*.zsh(.N); do
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}
source-dir "$ZSHRCD"
