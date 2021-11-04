export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH
path=(
  $path
  /usr/local/opt/go/libexec/bin
  $GLOBALGOPATH/bin
)

function gonint() {
  appname="${1:-mynewapp}"
  gitpath="${2:-github.com/mattmc3}"
  mkdir -p "$appname/pkg" "$appname/bin" "$appname/src/$gitpath/$appname"
  export GOPATH="$(pwd)/$appname"
  echo $GOPATH
  $VISUAL "$GOPATH/src/$gitpath/$appname"
}

function setgopath() {
  export GOPATH="${1:-$PWD}"
  echo $GOPATH
}

function resetgopath() {
  export GOPATH=${GLOBALGOPATH:-$HOME/Projects}
  echo $GOPATH
}

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
