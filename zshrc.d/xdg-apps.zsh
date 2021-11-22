# XDG apps
# define variables/aliases for different apps to use XDG locations

function _xdg_ensure_files {
  local f
  for f in $@; do
    if [[ ! -f "$f" ]]; then
      mkdir -p "$f:h" && touch "$f"
    fi
  done
}

# atom
export ATOM_HOME="$XDG_CONFIG_HOME"/atom

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine

# gpg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
alias gpg='gpg --homedir "$GNUPGHOME"'

# jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

# less
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# nodejs
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node.js/repl_history

# nuget
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# postgres
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

# readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# ruby
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
export TODOTXT_CFG_FILE="$XDG_CONFIG_HOME"/todo-txt/config
_xdg_ensure_files $TODOTXT_CFG_FILE

# wget
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget/wget-hsts"'
_xdg_ensure_files $WGETRC "$XDG_CACHE_HOME/wget/wget-hsts"

# z
export _Z_DATA="$XDG_DATA_HOME/z/data"
_xdg_ensure_files $_Z_DATA

# clean up
unfunction _xdg_ensure_files
