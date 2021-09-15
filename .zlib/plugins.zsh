# Filename:  plugins.zsh
# Version:   0.0.3
# Purpose:   A simple, elegant, and speedy git plugin manager for Zsh
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
#              plugin-loadfile

PLUGIN_HOME="${PLUGIN_HOME:-${ZDOTDIR:-$HOME}/.zplugins}"
[[ -d "$PLUGIN_HOME" ]] || mkdir -p "$PLUGIN_HOME"

function plugin-findinit {
  # find and display a plugin's init file
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
  [[ ${#initfiles[@]} -gt 0 ]] || { >&2 echo "plugin-findinit: no init file found; $1" && return 1 }
  REPLY=${initfiles[1]}
  echo $REPLY
}

function plugin-clone {
  [[ $# -gt 0 ]] || { >&2 echo "plugin-clone: expecting plugin arguments (user/repo)" && return 1 }
  local p; for p in $@; do
    local plugin_dir="$PLUGIN_HOME/${p##*/}"
    command git clone --depth 1 --recursive --shallow-submodules https://${PLUGIN_DOMAIN:-github.com}/$p.git "$plugin_dir"
    [[ $? -eq 0 ]] || { >&2 echo "plugin-clone: git clone failed; $1" && return 1 }
  done
}

function plugin-load {
  # load a plugin, doing a `git clone` first if necessary
  [[ $# -gt 0 ]] || { >&2 echo "plugin-load: expecting plugin arguments (user/repo)" && return 1 }
  local p; for p in $@; do
    local plugin_dir="$PLUGIN_HOME/${p##*/}"
    local initfile="$plugin_dir/${p##*/}.plugin.zsh"

    # git clone the plugin if not found
    if [[ ! -d "$plugin_dir" ]]; then
      plugin-clone "$p" || return 1

      # ensure an init file exists for the plugin
      local REPLY; plugin-findinit "$p" >/dev/null || return 1
      [[ "$REPLY" == "$initfile" ]] || echo "source \${0:A:h}/${REPLY:t}" > "$initfile"

      # compile the plugin's zsh files for speed
      [[ ${PLUGIN_COMPILE:-1} -eq 1 ]] && plugin-compile "$p"
    fi

    # source the plugin
    [[ -f "$initfile" ]] || { >&2 echo "plugin-load: missing init file, plugin not loaded; $1" && return 1 }
    source "$initfile"
    fpath+="${plugin_dir}"
    [[ -d ${plugin_dir}/functions ]] && fpath+="${plugin_dir}/functions"
  done
}

function plugin-compile {
  # compile .zsh to .zwc files
  local plugins; [[ $# -gt 0 ]] && plugins=($@) || plugins=($(plugin-ls))
  autoload -U zrecompile
  local p; for p in $plugins; do
    local zfile; for zfile in "$PLUGIN_HOME"/${p##*/}/**/*.zsh{,-theme}(.N); do
      zrecompile -pq "$zfile"
    done
  done
}

function plugin-ls {
  # list installed plugins
  local d; for d in "$PLUGIN_HOME"/*/.git/..(/N); do
    local plugin_dir="${d:a}"
    giturl=$(command git -C "$plugin_dir" remote get-url origin)
    user=${${giturl%/*}##*/}
    echo "$user/${plugin_dir:t}"
  done
}

function plugin-rm {
  # remove plugins
  local p; for p in $@; do
    local plugin_dir=$PLUGIN_HOME/${p##*/}
    [[ -d $plugin_dir ]] || { >&2 echo "plugin-rm: plugin not found $p" && return 1 }
    command rm -rf "$plugin_dir"
  done
}

function plugin-update {
  # update plugins by performing `git pull`, update all if
  local plugins; [[ $# -gt 0 ]] && plugins=($@) || plugins=($(plugin-ls))
  local p; for p in $plugins; do
    local plugin_dir=$PLUGIN_HOME/${p##*/}
    [[ -d $plugin_dir ]] || { >&2 echo "plugin-update: plugin not found $p" && return 1 }
    echo "updating $p..."
    command git -C "$plugin_dir" pull --quiet --recurse-submodules --depth 1 --rebase --autostash
    [[ $? -eq 0 ]] || { >&2 echo "*FAIL: git pull failed for plugin $p" && return 1 }
    [[ ${PLUGIN_COMPILE:-1} -eq 1 ]] && plugin-compile "$p"
  done
}

function plugin-loadfile {
  # load all plugins from .zplugins.txt
  local loadfile="${1:-${ZDOTDIR:-$HOME}/.zplugins.txt}"
  [[ -f "$loadfile" ]] || { >&2 echo "plugin-loadfile: plugin file not found; $loadfile" && return 1 }
  # load plugin list from file (supports empty lines and #comments)
  local plugins=("${(@f)$(command awk '!/^(#| *$)/' $loadfile)}")
  plugin-load $plugins
}
