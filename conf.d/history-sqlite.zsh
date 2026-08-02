#
# SQLite command history
#

HISTDBFILE=${HISTDBFILE:-$XDG_DATA_HOME/zsh/zsh_history.db}

# Set the short hostname
if [[ -z "$SHORT_HOST" ]]; then
  if [[ "$OSTYPE" = darwin* ]]; then
    # macOS's $HOST changes with dhcp, etc. Use LocalHostName if possible.
    SHORT_HOST=$(scutil --get LocalHostName 2>/dev/null) || SHORT_HOST="${HOST/.*/}"
  else
    SHORT_HOST="${HOST/.*/}"
  fi
fi

zmodload zsh/datetime 2>/dev/null
typeset -gA _history_sqlite_state
if [[ -n "${_history_sqlite_state[loaded]:-}" ]]; then
  return 0
fi
_history_sqlite_state[loaded]=1

_history_sqlite_insert() {
  emulate -L zsh
  setopt local_options
  local db=$1
  shift
  local -a values=("$@")
  local quote="'" i

  for i in {1..$#values}; do
    values[i]="'${values[i]//$quote/$quote$quote}'"
  done

  sqlite3 "$db" \
    "INSERT INTO zsh_history(host,user,sid,cwd,vcs_root,cmd,ret,pipestatus,start_ts,end_ts) VALUES(${(j:,:)values});" \
    >/dev/null 2>&1
}

# Walk up for a VCS root, setting REPLY. Stays fork-free to keep off the prompt path.
_history_sqlite_vcs_root() {
  emulate -L zsh
  setopt local_options
  local dir=$PWD

  REPLY=
  while true; do
    if [[ -e $dir/.git || -d $dir/.hg || -d $dir/.svn ]]; then
      REPLY=$dir
      return 0
    fi
    [[ $dir == / || -z $dir ]] && return 1
    dir=${dir:h}
  done
}

_history_sqlite_preexec() {
  local ignore_space=$options[hist_ignore_space]
  local reduce_blanks=$options[hist_reduce_blanks]
  emulate -L zsh
  setopt local_options extended_glob

  local cmd=$1
  [[ -z $cmd ]] && return 0
  [[ $ignore_space == on && $cmd[1] == ' ' ]] && return 0

  if [[ $reduce_blanks == on ]]; then
    cmd="${${${cmd//[[:blank:]][[:blank:]]##/ }##[[:blank:]]##}%%[[:blank:]]##}"
  fi

  _history_sqlite_state[cmd]=$cmd
  _history_sqlite_state[start_ts]=$EPOCHREALTIME
}

_history_sqlite_precmd() {
  local -a saved_pipestatus=("${pipestatus[@]}")
  local ignore_dups=$options[hist_ignore_dups]
  local ignore_all_dups=$options[hist_ignore_all_dups]
  emulate -L zsh
  setopt local_options

  local pipeline_status="${(j:,:)saved_pipestatus}"
  local return_code=$saved_pipestatus[-1]
  [[ -z "${_history_sqlite_state[cmd]:-}" ]] && return 0

  local end_ts=$EPOCHREALTIME
  local start_ts=${_history_sqlite_state[start_ts]:-0}
  local cmd=${_history_sqlite_state[cmd]}
  local session=${_history_sqlite_state[session]}
  local user=${USERNAME:-$USER}
  local REPLY vcs_root
  _history_sqlite_vcs_root && vcs_root=$REPLY

  if [[ ( $ignore_dups == on || $ignore_all_dups == on ) \
        && $cmd == "${_history_sqlite_state[last_cmd]:-}" ]]; then
    unset '_history_sqlite_state[cmd]'
    unset '_history_sqlite_state[start_ts]'
    return 0
  fi

  if [[ "${_history_sqlite_state[initialized]}" != "$HISTDBFILE" ]]; then
    _history_sqlite_init "$HISTDBFILE" \
      && _history_sqlite_state[initialized]=$HISTDBFILE
  fi

  if [[ "${_history_sqlite_state[initialized]}" == "$HISTDBFILE" ]]; then
    _history_sqlite_insert "$HISTDBFILE" "$SHORT_HOST" "$user" "$session" "$PWD" \
      "$vcs_root" "$cmd" "$return_code" "$pipeline_status" "$start_ts" "$end_ts" &|
  fi

  _history_sqlite_state[last_cmd]=$cmd
  unset '_history_sqlite_state[cmd]'
  unset '_history_sqlite_state[start_ts]'
}

_history_sqlite_migration_0() {
  emulate -L zsh
  setopt local_options
  local db=$1

  sqlite3 "$db" <<'SQL'
CREATE TABLE IF NOT EXISTS zsh_history (
  id         INTEGER PRIMARY KEY,
  host       TEXT,
  user       TEXT,
  sid        TEXT,
  cwd        TEXT,
  vcs_root   TEXT,
  cmd        TEXT,
  ret        INTEGER,
  pipestatus TEXT,
  start_ts   REAL,
  end_ts     REAL
);
CREATE INDEX IF NOT EXISTS idx_zsh_history_start_ts
  ON zsh_history(start_ts DESC);
CREATE INDEX IF NOT EXISTS idx_zsh_history_cmd
  ON zsh_history(cmd);
SQL
}

_history_sqlite_init() {
  emulate -L zsh
  setopt local_options
  local db=$1 current_version i

  mkdir -p -m 700 "${db:h}" || return 1
  chmod 700 "${db:h}" || return 1

  (( $+commands[sqlite3] )) || {
    print -ru2 "history-sqlite: sqlite3 required"
    return 1
  }

  sqlite3 "$db" "PRAGMA journal_mode=WAL;" >/dev/null 2>&1 || return 1
  chmod 600 "$db" || return 1
  current_version=$(sqlite3 "$db" 'PRAGMA user_version;' 2>/dev/null || echo 0)

  for i in {0..10}; do
    (( i < current_version )) && continue
    (( $+functions[_history_sqlite_migration_$i] )) || break
    "_history_sqlite_migration_$i" "$db" || return 1
    sqlite3 "$db" "PRAGMA user_version = $((i + 1));" \
      >/dev/null 2>&1 || return 1
  done
}

_history_sqlite_state[session]="${EPOCHREALTIME}-${RANDOM}-${RANDOM}-${TTY##*/}"

autoload -Uz add-zsh-hook
add-zsh-hook preexec _history_sqlite_preexec
add-zsh-hook precmd _history_sqlite_precmd
precmd_functions=(
  _history_sqlite_precmd
  ${precmd_functions:#_history_sqlite_precmd}
)

histdb() {
  emulate -L zsh
  local db=${HISTDBFILE:-$XDG_DATA_HOME/zsh/zsh_history.db}
  [[ -f $db ]] || {
    print -ru2 "histdb: no database at $db"
    return 1
  }
  (( $+commands[sqlite3] )) || {
    print -ru2 "histdb: sqlite3 not found"
    return 1
  }

  local -a help here fail success session limit reverse
  zparseopts -D -E -- \
    {h,-help}=help \
    {d,-here}=here \
    {f,-fail}=fail \
    {r,-reverse}=reverse \
    {s,-success}=success \
    {S,-session}=session \
    {n,-limit}:=limit \
    || {
      print -ru2 "usage: histdb [-d] [-f] [-s] [-S] [-r] [-n N] [pattern]"
      return 1
    }

  if (( $#help )); then
    print "usage: histdb [-d] [-f] [-s] [-S] [-r] [-n N] [pattern]"
    return 0
  fi

  local row_limit=${limit[-1]:-50}
  local pattern=${1:-}
  local order=ASC
  (( $#reverse )) && order=DESC
  local -a where
  local quote="'"

  (( $#here )) \
    && where+=("cwd = '${PWD//$quote/$quote$quote}'")
  (( $#session )) \
    && where+=("sid = '${_history_sqlite_state[session]//$quote/$quote$quote}'")
  (( $#fail )) && where+=("ret != 0")
  (( $#success )) && where+=("ret = 0")
  [[ -n $pattern ]] \
    && where+=("cmd LIKE '%${pattern//$quote/$quote$quote}%'")

  local sql="
    SELECT datetime(start_ts, 'unixepoch', 'localtime') AS time,
           printf('%.2f', end_ts - start_ts) AS dur,
           ret,
           replace(cwd, '$HOME', '~') AS cwd,
           cmd
    FROM zsh_history"
  (( $#where )) && sql+=" WHERE ${(j: AND :)where}"
  sql+=" ORDER BY start_ts $order LIMIT $row_limit;"

  sqlite3 -column -header "$db" "$sql"
}
