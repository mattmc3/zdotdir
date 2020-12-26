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
