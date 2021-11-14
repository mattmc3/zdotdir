### prezto framework

# set prezto variables
ZPREZTODIR="$ZPLUGINDIR/prezto"
# prezto doesn't set this variable, so borrow the omz one
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"

external_plugins=(
  # prezto first!
  sorin-ionescu/prezto
  # contribs next
  rupa/z
  zdharma-continuum/fast-syntax-highlighting
)

# clone prezto and contribs
() {
  local REPLY repo plugin_name initfile
  for repo in $external_plugins; do
    plugin_name="${repo:t}"
    plugin-clone https://github.com/${repo}.git
    if [[ ! -e $ZPLUGINDIR/$plugin_name/init.zsh ]]; then
      plugin-initfile $ZPLUGINDIR/$plugin_name >/dev/null
      ln -s $REPLY $ZPLUGINDIR/$plugin_name/init.zsh
    fi
  done
}

# load prezto
source "$ZPREZTODIR/init.zsh"
