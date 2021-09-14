# Filename:  unplugz.zsh
# Version:   0.0.1
# Purpose:   The dirt simple un-plugin-manager for git Zsh plugins.
# Author:    (c)mattmc3
# License:   https://unlicense.org
# Variables: PLUGIN_HOME, PLUGIN_COMPILE, PLUGIN_DOMAIN
# Usage:     In your $ZDOTDIR, create a file named .zplugins.txt listing the
#            plugins you use. You can include any Zsh plugin hosted on GitHub.
#            Unplugz supports frameworks (ex: sorin-ionescu/prezto),
#            themes (ex: sindresorhus/pure), or classic Zsh plugins
#            (ex: zsh-users/zsh-autosuggestions).
#            Then, in your .zshrc, add the following:
#              source /path/to/unplugz.zsh
#              plugin-loadall

PLUGIN_HOME="${PLUGIN_HOME:-${ZDOTDIR:-$HOME}/.zplugins}"
[[ -d "$PLUGIN_HOME" ]] || mkdir -p "$PLUGIN_HOME"

# find and display a plugin's init file
function plugin-initfile {
  local plugin_name=${1##*/}
  local plugin_dir="$PLUGIN_HOME/$plugin_name"
  [[ -d $plugin_dir ]] || return 1

  local initfiles=(
    # look for specific files first
    $plugin_dir/$plugin_name.plugin.zsh(.N)
    $plugin_dir/$plugin_name.zsh(.N)
    $plugin_dir/$plugin_name(.N)
    $plugin_dir/$plugin_name.zsh-theme(.N)
    $plugin_dir/init.zsh(.N)
    # then do more aggressive globbing
    $plugin_dir/*.plugin.zsh(.N)
    $plugin_dir/*.zsh(.N)
    $plugin_dir/*.zsh-theme(.N)
    $plugin_dir/*.sh(.N)
  )
  [[ ${#initfiles[@]} -gt 0 ]] || return 1
  REPLY=${initfiles[1]}
  echo $REPLY
}

# load a plugin, doing a `git clone` first if necessary
function plugin-load {
  [[ -n "$1" ]] || { >&2 echo "plugin-load: expecting plugin argument (user/repo)" && return 1 }
  local plugin_name=${1##*/}
  local plugin_dir="$PLUGIN_HOME/$plugin_name"
  local initfile="$plugin_dir/$plugin_name.plugin.zsh"

  # git clone the plugin if not found
  if [[ ! -d "$plugin_dir" ]]; then
    command git clone --depth 1 --recursive --shallow-submodules https://${PLUGIN_DOMAIN:-github.com}/$1.git "$plugin_dir"
    [[ $? -eq 0 ]] || return 1

    # ensure an init file exists for the plugin
    local REPLY
    plugin-initfile "$1" >/dev/null
    [[ $? -eq 0 ]] || { >&2 echo "plugin-load: plugin missing init file $1" && return 1 }
    if [[ "$REPLY" != "$initfile" ]]; then
      echo "source \${0:A:h}/${REPLY:t}" > "$initfile"
    fi

    # compile the plugin's zsh files for speed
    if [[ ${PLUGIN_COMPILE:-1} -eq 1 ]]; then
      autoload -U zrecompile
      local zfile; for zfile in "$PLUGIN_HOME"/**/*.zsh{,-theme}(.N); do
        zrecompile -pq "$zfile"
      done
    fi
  fi

  # source the plugin
  [[ -f "$initfile" ]] || { >&2 echo "plugin-load: plugin missing init file, not loaded $1" && return 1 }
  source "$initfile"
  return $?
}

function plugin-list {
  # list installed plugins
  local d; for d in "$PLUGIN_HOME"/*(/N); do
    if [[ -d $d/.git ]]; then
      giturl=$(command git -C "$d" remote get-url origin)
      user=${${${giturl%/*}%.git}##*/}
      repo=${${giturl##*/}%.git}
      echo "$user/$repo"
    fi
  done
}

function plugin-update {
  # update plugins by performing `git pull`
  local p; for p in $@; do
    local plugin=$PLUGIN_HOME/${p##*/}
    [[ -d $plugin ]] || { >&2 echo "plugin_update: plugin not found $p" && return 1 }
    echo "updating $p..."
    command git -C "$plugin" pull --quiet --recurse-submodules --depth 1 --rebase --autostash
    [[ $? -eq 0 ]] || { >&2 echo "*FAIL: git pull on plugin failed $p" && return 1 }
  done
}

function plugin-loadall {
  # load all plugins from .zplugins.txt
  local loadfile="${1:-${ZDOTDIR:-$HOME}/.zplugins.txt}"
  [[ -f "$loadfile" ]] || { >&2 echo "plugin-loadall: plugin file not found; $loadfile" && return 1 }
  # load plugin list from file (supports empty lines and #comments)
  local plugins=("${(@f)$(awk '!/^(#| *$)/' $loadfile)}")
  local p; for p in $plugins; do
    plugin-load "$p"
  done
}
