typeset -a ZSH_PLUGINS=()

function plugin-initfile() {
  # find and print a plugin's init file and set it to REPLY
  local plugin_dir="$1"
  local plugin_name="${1:t}"
  [[ -d $plugin_dir ]] || return 1
  local initfiles=(
    # look for specific files first
    $plugin_dir/$plugin_name.zsh(N)
    $plugin_dir/$plugin_name.plugin.zsh(N)
    $plugin_dir/init.zsh(N)
    $plugin_dir/$plugin_name(N)
    $plugin_dir/$plugin_name.zsh-theme(N)
    # then do more aggressive globbing
    $plugin_dir/*.plugin.zsh(N)
    $plugin_dir/*.zsh(N)
    $plugin_dir/*.zsh-theme(N)
    $plugin_dir/*.sh(N)
  )
  if [[ ${#initfiles[@]} -eq 0 ]]; then
    echo "plugin-initfile: no init file found; $1" >&2 && return 1
  fi
  REPLY=${initfiles[1]}
  echo $REPLY
}

function plugin-clone() {
  # git clone a plugin
  local giturl="$1"
  local plugin_name=${${giturl##*/}%.git}
  local plugin_dir="${2:-${ZDOTDIR:-$HOME/.config/zsh}/plugins/$plugin_name}"

  # clone if the plugin isn't there already
  if [[ ! -d $plugin_dir ]]; then
    command git clone --depth 1 --recursive --shallow-submodules $giturl $plugin_dir
    if [[ $? -ne 0 ]]; then
      echo "git clone failed for: $giturl" >&2 && return 1
    fi
    if [[ $plugin_name != zsh-syntax-highlighting ]]; then
      autoload -U zrecompile
      local f
      for f in $plugin_dir/**/*.zsh{,-theme}(N); do
        zrecompile -pq "$f"
      done
    fi
  fi
}

function plugin-load() {
  # source the plugin and add it to fpath
  # if needed, find and symlink an init file
  local plugin_path="$1"
  if [[ ! -d $plugin_path ]]; then
    if [[ ! "$1" == */* ]]; then
      plugin_path="${ZDOTDIR:-$HOME/.config/zsh}/plugins/$1"
    else
      echo "plugin dir not found: $1" >&2 && return 1
    fi
  fi
  local initfile=$plugin_path/${plugin_path:t}.zsh
  local REPLY
  if [[ ! -e $initfile ]]; then
    plugin-initfile $plugin_path >/dev/null
    ln -s $REPLY $initfile
  fi
  fpath+=$plugin_path
  if [[ -d $plugin_path/functions ]]; then
    fpath+=$plugin_path/functions
  fi
  source $initfile
  ZSH_PLUGINS+="$1"
}

function plugin-update () {
  local plugindir="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
  for d in $plugindir/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

function plugin-load-fromfile() {
  local plugin_file=${1:-$ZDOTDIR/zsh_plugins}

  if [[ ! -f $plugin_file ]]; then
    cat << 'EOPLUGINS' > $ZDOTDIR/zsh_plugins
mattmc3/zebrafish
sindresorhus/pure
zsh-users/zsh-autosuggestions
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting
EOPLUGINS
fi
  typeset -a plugins=("${(f)"$(<$plugin_file)"}")

  local repo
  local plugin_dir="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
  for repo in $plugins; do
    [[ $repo != \#* ]] || continue  # skip commented lines
    local plugin_name=${${repo##*/}%.git}
    [[ -d $plugin_dir/$plugin_name ]] || plugin-clone "https://github.com/$repo"
    plugin-load $plugin_dir/$plugin_name
  done
}
plugin-load-fromfile
