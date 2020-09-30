# https://wiki.archlinux.org/index.php/XDG_Base_Directory

### xdg -------------------------------------------------------------------- {{{
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"


### atom ------------------------------------------------------------------- {{{
export ATOM_HOME="${ATOM_HOME:-$XDG_CONFIG_HOME/atom}"


### docker ----------------------------------------------------------------- {{{
export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
export MACHINE_STORAGE_PATH="${MACHINE_STORAGE_PATH:-$XDG_DATA_HOME/docker-machine}"


### gpg -------------------------------------------------------------------- {{{
export GNUPGHOME="${GNUPGHOME:-$XDG_DATA_HOME/gnupg}"
alias gpg='gpg2 --homedir "$GNUPGHOME"'


### jupyter ---------------------------------------------------------------- {{{
export IPYTHONDIR="${IPYTHONDIR:-$XDG_CONFIG_HOME/jupyter}"
export JUPYTER_CONFIG_DIR="${JUPYTER_CONFIG_DIR:-$XDG_CONFIG_HOME/jupyter}"


### less ------------------------------------------------------------------- {{{
export LESSKEY="${LESSKEY:-$XDG_CONFIG_HOME/less/lesskey}"
export LESSHISTFILE="${LESSHISTFILE:-$XDG_CACHE_HOME/less/history}"


### libdvdcss -------------------------------------------------------------- {{{
export DVDCSS_CACHE="${DVDCSS_CACHE:-$XDG_DATA_HOME/dvdcss}"


### node.js ---------------------------------------------------------------- {{{
export NVM_DIR="${NVM_DIR:-$XDG_DATA_HOME/nvm}"
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/node/node_repl_history}"


### python ----------------------------------------------------------------- {{{
export PYLINTHOME="${PYLINTHOME:-$XDG_CACHE_HOME/pylint}"
export WORKON_HOME="${WORKON_HOME:-$XDG_DATA_HOME/venvs}"


### postgres --------------------------------------------------------------- {{{
export PSQLRC="${PSQLRC:-$XDG_CONFIG_HOME/pg/psqlrc}"
export PSQL_HISTORY="${PSQL_HISTORY:-$XDG_CACHE_HOME/pg/psql_history}"
export PGPASSFILE="${PGPASSFILE:-$XDG_CONFIG_HOME/pg/pgpass}"
export PGSERVICEFILE="${PGSERVICEFILE:-$XDG_CONFIG_HOME/pg/pg_service.conf}"


### readline --------------------------------------------------------------- {{{
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"


### ruby ------------------------------------------------------------------- {{{
export GEM_HOME="${GEM_HOME:-$XDG_DATA_HOME/gem}"
export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem}"
export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle}"


### screen ----------------------------------------------------------------- {{{
export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"


### sqlite ----------------------------------------------------------------- {{{
export SQLITE_HISTORY="${SQLITE_HISTORY:-$XDG_DATA_HOME/sqlite/history}"


### subversion ------------------------------------------------------------- {{{
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'


### tmux ------------------------------------------------------------------- {{{
export TMUX_TMPDIR="${TMUX_TMPDIR:-$XDG_RUNTIME_DIR/tmux}"
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'


### todo-txt --------------------------------------------------------------- {{{
export TODOTXT_CFG_FILE="${TODOTXT_CFG_FILE:-$XDG_CONFIG_HOME/todo-txt/config}"


### vagrant ---------------------------------------------------------------- {{{
export VAGRANT_HOME="${VAGRANT_HOME:-$XDG_DATA_HOME/vagrant}"
export VAGRANT_ALIAS_FILE="${VAGRANT_ALIAS_FILE:-$XDG_DATA_HOME/vagrant/aliases}"


### wget ------------------------------------------------------------------- {{{
export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgentrc}"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'


### z ---------------------------------------------------------------------- {{{
export _Z_DATA="${_Z_DATA:-$XDG_DATA_HOME/z/data}"
if [[ ! -f "$_Z_DATA" ]]; then
  mkdir -p "$_Z_DATA:h" && touch "$_Z_DATA"
fi
