function update_git_completions {
  # Download the latest git completion scripts
  0=${(%):-%x}
  local thisdir="${0:A:h}"
  local dest="${1:-$thisdir}"
  local giturl=https://raw.githubusercontent.com/git/git/master/contrib/completion
  curl -fsSL $giturl/git-completion.bash -o "$dest/git-completion.bash"
  curl -fsSL $giturl/git-completion.zsh -o "$dest/_git"
}
