alias get="git"
alias gadd="git add ."
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias sourcetree='open -a SourceTree'

g() {
  # No arguments: `git status`
  # With arguments: acts like `git`
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}
