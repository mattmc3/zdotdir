### plugin variables -------------------------------------------------------------------
ZPLUGINDIR="$ZDOTDIR/plugins"

prezto_plugins=(
  # prezto first!
  sorin-ionescu/prezto
  # prompts
  # mafredri/zsh-async
  sindresorhus/pure
  # contribs
  ohmyzsh/ohmyzsh
  rupa/z
  # zsh-users/zsh-autosuggestions
  # zsh-users/zsh-history-substring-search
  # zsh-users/zsh-completions
  # zsh-users/zsh-syntax-highlighting
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
    fpath+=$ZPLUGINDIR/$plugin_name
  done
}

# load prezto
source "$ZPREZTODIR/init.zsh"

# fix prezto settings to what I prefer
setopt emacs                  # use emacs keybindings in the shell
setopt glob_dots              # include dotfiles when globbing
setopt emacs                  # use emacs keybindings in the shell
setopt pushd_minus            # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack

# fix prezto history
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
[[ -f "$HISTFILE" ]] || { mkdir -p "$HISTFILE:h" && touch "$HISTFILE" }
SAVEHIST=20000
HISTSIZE=100000

setopt hist_no_store          # don't store history commands
setopt hist_reduce_blanks     # remove superfluous blanks from each command line being added to the history list

alias history="fc -li"        # make the history command more useful
