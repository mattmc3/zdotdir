### antibody {{{

# antibody home
ANTIBODY_HOME=$(antibody home)

# oh-my-zsh
ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh
DISABLE_AUTO_UPDATE="true"
ZSH_DISABLE_COMPFIX="true"
export ZSH_CUSTOM=$ZDOTDIR/omz_custom

# omz plugins
plugins=(
  # do this first!
  xdg

  # alphabetical
  brew
  colemak
  colored-man-pages
  common-aliases
  dotfiles
  extract
  git
  golang
  groovy
  java
  jupyter
  lpass
  macos
  mono
  python
  ruby
  screen
  ssh
  sublime
  tmux
  todo-txt
  vscode
  z
)

# omz themes I like:
# avit, juanghurtado, lambda, refined, steeef, terminalparty, wezm
ZSH_THEME=${ZSH_THEME:-refined}

source <(antibody init)
antibody bundle < $ZDOTDIR/conf.d/20_antibody_plugins.txt

# post-activities after plugins load

# to handle autosuggest fg=8 blending with terminal background
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# spaceship prompt config
# https://github.com/denysdovhan/spaceship-prompt
# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md
SPACESHIP_CHAR_SYMBOL='%% '
### }}}
