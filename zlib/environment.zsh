# set general stuff
export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

export CLICOLOR="1"
export LSCOLORS="ExfxcxdxbxGxDxabagacad"

export PAGER="less"
export EDITOR="vim"
export VISUAL="code"

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# path
path=(
  $HOME/bin
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  $HOME/.emacs.d/bin
  /usr/local/share/npm/bin
  /usr/local/opt/go/libexec/bin
  $HOME/Projects/golang/bin
  /usr/local/opt/ruby/bin
)

# ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# dotfiles
[[ -d "$HOME/.dotfiles" ]] && export DOTFILES="$HOME/.dotfiles"
