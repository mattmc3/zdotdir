### environment ------------------------------------------------------------ {{{

# set general stuff
export LSCOLORS=ExFxBxDxCxegedabagacad
export TZ="America/New_York"
export TERM="xterm-256color"
export EDITOR=vim
export VISUAL='subl -n -w'
export PAGER=less

# path
path=(
  $HOME/bin
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  /usr/local/share/npm/bin
  .
  $path
)
typeset -gxU path

# dotfiles
[[ -d "$HOME/.config/dotfiles" ]] && export DOTFILES="$HOME/.config/dotfiles"
