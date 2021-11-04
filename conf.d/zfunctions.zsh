# autoload functions
function autoload_funcdir {
  if [[ ! -d "$1" ]]; then
    >&2 echo "Function directory not found: $1" && return 1
  fi
  fpath=("$1" $fpath)
  local fn; for fn in "$1"/*(.N); do
    autoload -Uz "$fn"
  done
}

fndirs=(
  ${ZDOTDIR:-$HOME}/.zfunctions
  ${ZDOTDIR:-$HOME}/.zfunctions/*/(N)
  ${ZDOTDIR:-~/.config/zsh}/zfunctions
  ${ZDOTDIR:-~/.config/zsh}/zfunctions/*/(N)
  ${ZDOTDIR:-~/.config/zsh}/functions
  ${ZDOTDIR:-~/.config/zsh}/functions/*/(N)
)
for d in $fndirs; do
  [[ -d $d ]] || continue
  autoload_funcdir "$d"
done
unset fndirs d
