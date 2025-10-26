#
# git
#

zstyle ':completion:*:*:git:*' script $ZSH_CONFIG_DIR/completions/git-completion.bash

# Aliases
if ! zstyle -t ':zsh:custom:git:alias' skip; then
  alias gad="git add"
  alias gbn="git rev-parse --abbrev-ref HEAD"
  alias gcd1="git clone --depth 1 https://github.com/"
  alias gcl="git clean"
  alias gclone="git clone git@github.com:mattmc3/"
  alias gcmt="git commit -am "
  alias gco="git checkout"
  alias gcob="git checkout -b "
  alias gcod="git checkout develop"
  alias gcom="git checkout main"
  alias get="git"
  alias glg="git log"
  alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
  alias gpll="git pull"
  alias gpristine="git reset --hard && git clean -fdx"
  alias gpsh="git push"
  alias gpsuo="git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)"
  alias grv="git remote -v"
  alias gsh="git stash"
  alias gst="git status -sb"
fi
