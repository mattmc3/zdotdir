### plugin variables -------------------------------------------------------------------
ZPLUGINDIR="$ZDOTDIR/plugins"

prezto_plugins=(
  # prezto first!
  sorin-ionescu/prezto
  # contribs next
  ohmyzsh/ohmyzsh
  rupa/z
  zdharma-continuum/fast-syntax-highlighting
)

# set prezto variables
ZPREZTODIR="$ZPLUGINDIR/prezto"
# prezto doesn't set this variable, so borrow the omz one
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"

# clone prezto and contribs
() {
  local REPLY repo plugin_name initfile
  for repo in $prezto_plugins; do
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

# fix prezto settings to what I prefer
setopt emacs                  # use emacs keybindings in the shell
setopt glob_dots              # include dotfiles when globbing
setopt emacs                  # use emacs keybindings in the shell
setopt pushd_minus            # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack
