#
# Source zsh files in a conf.d directory.
#

typeset -a _confd=(
  ${ZDOTDIR:-~}/.zshrc.d(N/)
  ${ZDOTDIR:-~}/zshrc.d(N/)
  ${ZDOTDIR:-~/.config/zsh}/conf.d(N/)
)
export ZSHRCD=${_confd[1]}
unset _confd

function source-dir {
  [[ -d "$1" ]] || return 1
  local f
  for f in "$1"/*.zsh(.N); do
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}
source-dir "$ZSHRCD"
