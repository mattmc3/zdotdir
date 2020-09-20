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
  # export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home"
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
  export PENTAHO_JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

  # alias j12="export JAVA_HOME=\`/usr/libexec/java_home -v 12\`; java -version"
  # alias j11="export JAVA_HOME=\`/usr/libexec/java_home -v 11\`; java -version"
  # alias j10="export JAVA_HOME=\`/usr/libexec/java_home -v 10\`; java -version"
fi

### jupyter ---------------------------------------------------------------- {{{
JUPYTER_HOME="$PROJECTS_HOME/jupyter"

# jupyter can use the BROWSER variable
# if [[ "$OSTYPE" == darwin* ]]; then
#   export BROWSER=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
#   export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox
# fi

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

### python ----------------------------------------------------------------- {{{
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

### todo-txt --------------------------------------------------------------- {{{
alias t="todo.sh"
alias todos="$VISUAL $HOME/Desktop/todo.txt"
