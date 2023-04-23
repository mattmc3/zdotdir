#
# git
#

# References
# - https://www.oliverspryn.com/blog/adding-git-completion-to-zsh

function update_git_completions {
  # Download the git scripts
  local giturl=https://raw.githubusercontent.com/git/git/master/contrib/completion
  local dest=${1:-${XDG_DATA_HOME:-~/.local/share}/zsh/completions}
  [[ -d $dest ]] || mkdir -p $dest
  curl -fsSL $giturl/git-completion.bash -o $dest/git-completion.bash
  curl -fsSL $giturl/git-completion.zsh -o $dest/_git
}

# Add completions
fpath=(${XDG_DATA_HOME:-~/.local/share}/zsh/completions $fpath)
[[ -f ${fpath[1]}/_git ]] || update_git_completions
zstyle ':completion:*:*:git:*' script ${fpath[1]}/git-completion.bash
