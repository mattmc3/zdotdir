export REPO_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/repos"

function repo {
  0=${(%):-%x}
  "${0:a:h}/bin/repo" "$@"
}
