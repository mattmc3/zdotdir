# set general stuff
export TZ="America/New_York"

# path
path=(
  $HOME/bin
  $path
  /usr/local/opt/ruby/bin
  $HOME/.emacs.d/bin
)
typeset -gxU path

# dotfiles
[[ -d "$HOME/.config/dotfiles" ]] && export DOTFILES="$HOME/.config/dotfiles"
