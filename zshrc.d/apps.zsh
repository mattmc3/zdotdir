# apps -
#   define aliases and variables for different apps

# curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# dotfiles
export DOTFILES=~/.config/dotfiles
alias dotf='cd "$DOTFILES"'
alias dotfed='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'

# emacs
path=($path ~/.emacs.d/bin ~/.config/emacs/bin)

# git
alias get="git"
alias gadd="git add ."
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias sourcetree='open -a SourceTree'

# golang
export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH
path=(
  $path
  /usr/local/opt/go/libexec/bin
  $GLOBALGOPATH/bin
)
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

# groovy
if [[ "$OSTYPE" == darwin* ]]; then
  export GROOVY_HOME=/usr/local/opt/groovy/libexec  # per homebrew
  export GROOVY_TURN_OFF_JAVA_WARNINGS="true"
fi

# homebrew
alias bcu="brew cu"
alias brewup="brew update && brew upgrade"
alias caskup="brew cu -af"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:---appdir=/Applications}"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# java
alias setjavahome="export JAVA_HOME=\`/usr/libexec/java_home\`"

# jupyter
JUPYTER_HOME="${JUPYTER_HOME:-$HOME/Projects/jupyter}"
[[ -d $JUPYTER_HOME ]] || mkdir -p $JUPYTER_HOME

# lpass
export LPASS_AGENT_TIMEOUT="${LPASS_AGENT_TIMEOUT:-0}"

# nodejs
path+=/usr/local/share/npm/bin

# python
export WORKON_HOME="$XDG_DATA_HOME"/venvs
[[ -d "$WORKON_HOME" ]] || mkdir -p "$WORKON_HOME"
alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

# ruby
# per homebrew:
# If you need to have ruby first in your PATH, run:
#   echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc

# For compilers to find ruby you may need to set:
#   export LDFLAGS="-L/usr/local/opt/ruby/lib"
#   export CPPFLAGS="-I/usr/local/opt/ruby/include"

# For pkg-config to find ruby you may need to set:
#   export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$GEM_HOME/ruby/3.0.0/bin:$PATH"

# todo-txt
alias t="todo.sh"
alias todos="$VISUAL $HOME/Desktop/todo.txt"
