### prezto framework

# set prezto variables
ZPREZTODIR="${ZPREZTODIR:-${ZDOTDIR:-$HOME}/.zprezto}"
ZPREZTO_CONTRIB_DIR="$ZPREZTODIR/contrib"
ZPREZTO_CONTRIB_FILE="${ZDOTDIR:-$HOME}/zprezto_contribs.zsh"
# prezto doesn't set this variable, so borrow the omz one
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"

function zprezto_compile() {
  local dir="${1:a}"
  echo "zcompiling $dir"
  autoload -U zrecompile
  for f in "$dir"/**/*.zsh{,-theme}(.N); do
    zrecompile -pq "$f"
  done
}

function zprezto_clone {
  # clone a prezto/contrib repo
  local repo="$1"
  local dest="$2"
  command git clone --depth 1 --recursive --shallow-submodules https://github.com/${repo} "${dest}"
  zprezto_compile "$dest"
}

function plugin_initfile {
  # find and print a plugin's init file and set it to REPLY
  local plugin_dir="$1"
  local plugin_name="${1##*/}"
  [[ -d $plugin_dir ]] || return 1

  local initfiles=(
    # look for specific files first
    $plugin_dir/init.zsh(.N)
    $plugin_dir/$plugin_name.plugin.zsh(.N)
    $plugin_dir/$plugin_name.zsh(.N)
    $plugin_dir/$plugin_name(.N)
    $plugin_dir/$plugin_name.zsh-theme(.N)
    # then do more aggressive globbing
    $plugin_dir/*.plugin.zsh(.N)
    $plugin_dir/*.zsh(.N)
    $plugin_dir/*.zsh-theme(.N)
    $plugin_dir/*.sh(.N)
  )
  [[ ${#initfiles[@]} -gt 0 ]] || { >&2 echo "plugin_initfile: no init file found; $1" && return 1 }
  REPLY=${initfiles[1]}
  echo $REPLY
}

function zpreztoup() {
  # update prezto, and the contrib dependencies
  zprezto-update
  local d f contrib_dir
  for d in $ZPREZTO_CONTRIB_DIR/*/external/.git(N); do
    contrib_dir="${d:h}"
    echo "Updating $contrib_dir:h:t"
    command git -C "$contrib_dir" pull --quiet --recurse-submodules --depth 1 --rebase --autostash
    zprezto_compile "$contrib_dir"
  done
}

# clone prezto and contribs
() {
  local REPLY repo
  source "$ZPREZTO_CONTRIB_FILE"
  # parse the contribs file, which allows "#comments"
  # if [[ -f "$ZPREZTO_CONTRIB_FILE" ]]; then
  #   contribs=("${(@f)$(command awk '!/^(#| *$)/' $ZPREZTO_CONTRIB_FILE)}")
  # fi
  # clone prezto itself
  if [[ ! -d "$ZPREZTODIR" ]]; then
    zprezto_clone "sorin-ionescu/prezto" "$ZPREZTODIR"
  fi
  # clone contribs
  for repo in $zprezto_contribs; do
    local contrib_subdir="$ZPREZTO_CONTRIB_DIR/${repo##*/}"
    if [[ ! -d "$contrib_subdir" ]]; then
      zprezto_clone "$repo" "$contrib_subdir"/external
      plugin_initfile "$contrib_subdir"/external >/dev/null || return 1
      echo "source \${0:A:h}/external/${REPLY:t}" > "$contrib_subdir"/init.zsh
    fi
  done
}

# load prezto
source "$ZPREZTODIR/init.zsh"
