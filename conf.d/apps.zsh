# apps -
#   define aliases and variables for different apps

# xdg
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/Desktop}
  export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-$HOME/Documents}
  export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
  export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/Music}
  export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}
  export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-$HOME/Videos}
  export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}
fi

# curl
path=($path /usr/local/opt/curl/bin)

# dotfiles
export DOTFILES=~/.config/dotfiles
alias dotf='cd "$DOTFILES"'
alias dotfed='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'
# path=($path $DOTFILES/home/pybin)

# emacs
for p in ~/.emacs.d/bin ~/.config/emacs/bin; do
  [[ ! -d "$p" ]] || path=($path $p)
done

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

# gpg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
alias gpg='gpg --homedir "$GNUPGHOME"'

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
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
JUPYTER_HOME="${JUPYTER_HOME:-$HOME/Projects/jupyter}"
[[ -d $JUPYTER_HOME ]] || mkdir -p $JUPYTER_HOME

# less
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# lpass
export LPASS_AGENT_TIMEOUT="${LPASS_AGENT_TIMEOUT:-0}"

# nodejs
path+=/usr/local/share/npm/bin
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node.js/repl_history

# nuget
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# postgres
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

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

# readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# ruby
# per homebrew:
# If you need to have ruby first in your PATH, run:
#   echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
if [[ -d "/opt/homebrew/opt/ruby/bin" ]]; then
  export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.1.0/bin:$PATH"
fi
if [[ -d "$HOME/.gem/ruby/3.1.0/bin" ]]; then
  export PATH="$HOME/.gem/ruby/3.1.0/bin:$PATH"
fi

# For compilers to find ruby you may need to set:
#   export LDFLAGS="-L/usr/local/opt/ruby/lib"
#   export CPPFLAGS="-I/usr/local/opt/ruby/include"

# For pkg-config to find ruby you may need to set:
#   export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
path=($path /usr/local/opt/ruby/bin $GEM_HOME/ruby/3.0.0/bin)
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem

# rust
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# screen
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc

# tmux
export TMUX_CONFIG="$XDG_CONFIG_HOME"/tmux/tmux.conf
alias tmux='tmux -f "$TMUX_CONFIG"'

# todo-txt
alias t="todo.sh"
alias todos="$VISUAL $HOME/Desktop/todo.txt"

# wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget/wget-hsts"'

# z
export _Z_DATA="$XDG_DATA_HOME/z/data"

# clear dupes
typeset -gU cdpath fpath mailpath path
