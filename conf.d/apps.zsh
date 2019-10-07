### atom ------------------------------------------------------------------- {{{
export ATOM_HOME="${ATOM_HOME:-$XDG_CONFIG_HOME/atom}"


### colemak ---------------------------------------------------------------- {{{
# fix typos
alias cs='cd'  # darn colemak


### docker ----------------------------------------------------------------- {{{
export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
export MACHINE_STORAGE_PATH="${MACHINE_STORAGE_PATH:-$XDG_DATA_HOME/docker-machine}"


### dotfiles --------------------------------------------------------------- {{{
alias dotf='cd "$DOTFILES" && $VISUAL .'


### git -------------------------------------------------------------------- {{{
alias get="git"
alias gadd="git add ."
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias sourcetree='open -a SourceTree'


### golang ----------------------------------------------------------------- {{{
export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin # Add GOPATH/bin to PATH for scripting

alias gob='go build'
alias goc='go clean'
alias god='go doc'
alias gof='go fmt'
alias gofa='go fmt . ./...'
alias gog='go get'
alias goi='go install'
alias gol='go list'
alias gor='go run'
alias got='go test'
alias gov='go vet'

resetgopath() {
  export GOPATH=$GLOBALGOPATH
  echo $GOPATH
}

setgopath() {
  export GOPATH="$(pwd)"
  echo $GOPATH
}

goinit() {
  appname="${1:-mynewapp}"
  gitpath="${2:-github.com/mattmc3}"
  mkdir -p "$appname/pkg" "$appname/bin" "$appname/src/$gitpath/$appname"
  export GOPATH="$(pwd)/$appname"
  echo $GOPATH
  $VISUAL "$GOPATH/src/$gitpath/$appname"
}


### gpg -------------------------------------------------------------------- {{{
export GNUPGHOME="${GNUPGHOME:-$XDG_DATA_HOME/gnupg}"
alias gpg='gpg2 --homedir "$GNUPGHOME"'


### groovy ----------------------------------------------------------------- {{{
if [[ "$OSTYPE" == darwin* ]]; then
  export GROOVY_HOME=/usr/local/opt/groovy/libexec  # per homebrew
  export GROOVY_TURN_OFF_JAVA_WARNINGS="true"
fi


### images ----------------------------------------------------------------- {{{
# auto-orient images based on exif tags
alias autorotate="jhead -autorot"


### java ------------------------------------------------------------------- {{{
if [[ "$OSTYPE" == darwin* ]]; then
  # run this: /usr/libexec/java_home -v 10
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home"

  # alias j12="export JAVA_HOME=\`/usr/libexec/java_home -v 12\`; java -version"
  # alias j11="export JAVA_HOME=\`/usr/libexec/java_home -v 11\`; java -version"
  # alias j10="export JAVA_HOME=\`/usr/libexec/java_home -v 10\`; java -version"
fi


### jupyter ---------------------------------------------------------------- {{{
alias juno="jupyter notebook"
export IPYTHONDIR="${IPYTHONDIR:-$XDG_CONFIG_HOME/jupyter}"
export JUPYTER_CONFIG_DIR="${JUPYTER_CONFIG_DIR:-$XDG_CONFIG_HOME/jupyter}"

# jupyter can use the BROWSER variable
# if [[ "$OSTYPE" == darwin* ]]; then
#   export BROWSER=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
#   export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox
# fi


### less ------------------------------------------------------------------- {{{
export LESSKEY="${LESSKEY:-$XDG_CONFIG_HOME/less/lesskey}"
export LESSHISTFILE="${LESSHISTFILE:-$XDG_CACHE_HOME/less/history}"


### libdvdcss -------------------------------------------------------------- {{{
export DVDCSS_CACHE="${DVDCSS_CACHE:-$XDG_DATA_HOME/dvdcss}"


### lpass ------------------------------------------------------------------ {{{
export LPASS_AGENT_TIMEOUT="${LPASS_AGENT_TIMEOUT:-0}"


### macos ------------------------------------------------------------------ {{{
if [[ "$OSTYPE" == darwin* ]]; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:---appdir=/Applications}"
  alias bcu="brew cu"
  alias lmk="say 'Process complete.'"
  alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

  alias brewup="brew update && brew upgrade"
  alias caskup="brew cu -af"
  alias bcu="brew cu"
  alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to clipboard.'"

  # Recursively clean files
  alias cleands="find . -name '.DS_Store' -depth -exec rm {} \;"

  # Canonical hex dump; some systems have this symlinked
  command -v hd > /dev/null || alias hd="hexdump -C"

  # macOS has no 'md5sum', so use 'md5' as a fallback
  command -v md5sum > /dev/null || alias md5sum="md5"

  # macOS has no 'sha1sum', so use 'shasum' as a fallback
  command -v sha1sum > /dev/null || alias sha1sum="shasum"
fi


### node.js ---------------------------------------------------------------- {{{
export NVM_DIR="${NVM_DIR:-$XDG_DATA_HOME/nvm}"
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/node/node_repl_history}"


### python ----------------------------------------------------------------- {{{
export PYLINTHOME="${PYLINTHOME:-$XDG_CACHE_HOME/pylint}"
export WORKON_HOME="${WORKON_HOME:-$XDG_DATA_HOME/venvs}"
compdef '_files -W "$WORKON_HOME"' workon &> /dev/null

alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"


### postgres --------------------------------------------------------------- {{{
export PSQLRC="${PSQLRC:-$XDG_CONFIG_HOME/pg/psqlrc}"
export PSQL_HISTORY="${PSQL_HISTORY:-$XDG_CACHE_HOME/pg/psql_history}"
export PGPASSFILE="${PGPASSFILE:-$XDG_CONFIG_HOME/pg/pgpass}"
export PGSERVICEFILE="${PGSERVICEFILE:-$XDG_CONFIG_HOME/pg/pg_service.conf}"


### readline --------------------------------------------------------------- {{{
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"


### ruby ------------------------------------------------------------------- {{{
# brew doesn't link ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export GEM_HOME="${GEM_HOME:-$XDG_DATA_HOME/gem}"
export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem}"
export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle}"


### screen ----------------------------------------------------------------- {{{
export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"


### sqlite ----------------------------------------------------------------- {{{
export SQLITE_HISTORY="${SQLITE_HISTORY:-$XDG_DATA_HOME/sqlite/history}"


### ssh -------------------------------------------------------------------- {{{
# if [[ -f ~/.ssh/id_rsa ]] && ! ssh-add -L >/dev/null; then
#   if [[ "$OSTYPE" == darwin* ]]; then
#     # TODO: review b/c this is a (small) hit performance-wise
#     # macos uses keychain with ssh -K
#     ssh-add -K ~/.ssh/id_rsa &> /dev/null
#   else
#     ssh-add ~/.ssh/id_rsa &> /dev/null
#   fi
# fi


### subversion ------------------------------------------------------------- {{{
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'


### tmux ------------------------------------------------------------------- {{{
export TMUX_TMPDIR="${TMUX_TMPDIR:-$XDG_RUNTIME_DIR/tmux}"
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'


### todo-txt --------------------------------------------------------------- {{{
alias t="todo.sh"
alias todos="$VISUAL $HOME/Desktop/todo.txt"
export TODOTXT_CFG_FILE="${TODOTXT_CFG_FILE:-$XDG_CONFIG_HOME/todo-txt/config}"


### vagrant ---------------------------------------------------------------- {{{
export VAGRANT_HOME="${VAGRANT_HOME:-$XDG_DATA_HOME/vagrant}"
export VAGRANT_ALIAS_FILE="${VAGRANT_ALIAS_FILE:-$XDG_DATA_HOME/vagrant/aliases}"


### wget ------------------------------------------------------------------- {{{
export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgentrc}"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'


### z ---------------------------------------------------------------------- {{{
export _Z_DATA="${_Z_DATA:-$XDG_DATA_HOME/z/data}"
