# setup ohmyzsh
export ZSH=$ZDOTDIR/plugins/ohmyzsh

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# good themes: refined, steeef, lambda, terminalparty
ZSH_THEME=""
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
ZSH_DISABLE_COMPFIX="true"
ZSH_COMPDUMP="${XDG_CACHE_HOME:-~/.cache}"/zsh/zcompdump
[[ -f "$ZSH_COMPDUMP" ]] || mkdir -p "${ZSH_COMPDUMP:h}"
ZSH_CUSTOM=$ZDOTDIR/plugins/zsh_custom

# omz overrides
[[ -d $ZSH_CUSTOM ]] || zplugr clone mattmc3/zsh_custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  copydir
  copyfile
  extract
  history
  osx
  python
  shrink-path
  sublime
  tmux
  z
)

# load ohmyzsh
zplugr source ohmyzsh/ohmyzsh
