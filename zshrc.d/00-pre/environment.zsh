# set general stuff
export TZ="America/New_York"
export VISUAL="code"

# path
path=(
  $HOME/bin
  $path
  /usr/local/opt/ruby/bin
  $HOME/.emacs.d/bin
)
typeset -gxU path

# dotfiles
if [[ -d "$HOME/.dotfiles" ]]; then
  export DOTFILES="$HOME/.dotfiles"
elif [[ -d "$HOME/.config/dotfiles" ]]; then
  export DOTFILES="$HOME/.config/dotfiles"
fi

PROJECTS_HOME="$HOME/Projects"
