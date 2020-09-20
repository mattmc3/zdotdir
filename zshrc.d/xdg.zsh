# XDG
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# https://wiki.archlinux.org/index.php/XDG_user_directories

# Make sure XDG dirs are set
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="$HOME/.xdg"

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR="$HOME/Desktop"
  export XDG_DOCUMENTS_DIR="$HOME/Documents"
  export XDG_DOWNLOAD_DIR="$HOME/Downloads"
  export XDG_MUSIC_DIR="$HOME/Music"
  export XDG_PICTURES_DIR="$HOME/Pictures"
  export XDG_PUBLICSHARE_DIR="$HOME/Public"
fi


### atom ------------------------------------------------------------------- {{{
export ATOM_HOME="$XDG_CONFIG_HOME/atom"


### docker ----------------------------------------------------------------- {{{
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"


### gpg -------------------------------------------------------------------- {{{
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
alias gpg='gpg2 --homedir "$GNUPGHOME"'


### jupyter ---------------------------------------------------------------- {{{
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"


### less ------------------------------------------------------------------- {{{
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
[[ -f "$LESSHISTFILE" ]] || { mkdir -p $(dirname "$LESSHISTFILE") && touch $LESSHISTFILE }


### libdvdcss -------------------------------------------------------------- {{{
export DVDCSS_CACHE="$XDG_DATA_HOME/dvdcss"


### node.js ---------------------------------------------------------------- {{{
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"


### python ----------------------------------------------------------------- {{{
export PYLINTHOME="$XDG_CACHE_HOME/pylint"


### postgres --------------------------------------------------------------- {{{
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"


### readline --------------------------------------------------------------- {{{
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
[[ -f "$INPUTRC" ]] || { mkdir -p $(dirname "$INPUTRC") && touch $INPUTRC }


### ruby ------------------------------------------------------------------- {{{
# brew doesn't link ruby
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle"


### screen ----------------------------------------------------------------- {{{
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"


### sqlite ----------------------------------------------------------------- {{{
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite/history"


### subversion ------------------------------------------------------------- {{{
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'


### todo-txt --------------------------------------------------------------- {{{
export TODOTXT_CFG_FILE="$XDG_CONFIG_HOME/todo-txt/config"


### tmux ------------------------------------------------------------------- {{{
export TMUX_TMPDIR="$XDG_RUNTIME_DIR/tmux"
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'


### vagrant ---------------------------------------------------------------- {{{
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME/vagrant/aliases"


### wget ------------------------------------------------------------------- {{{
export WGETRC="$XDG_CONFIG_HOME/wget/wgentrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'


### z ---------------------------------------------------------------------- {{{
export _Z_DATA="$XDG_DATA_HOME/z/data"
