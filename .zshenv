# ~/.zshenv should only be a one-liner that sources this file
# echo '. ~/.zsh/.zshenv' >| ~/.zshenv

export ZDOTDIR=${ZDOTDIR:-~/.zsh}

# xdg
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state
export XDG_CACHE_HOME=~/.cache
export XDG_RUNTIME_DIR=~/.xdg

# editors
export EDITOR='hx'
export VISUAL='code'
export PAGER='less'
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

typeset -gU fpath path
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

export LESS='-g -i -M -R -S -w -z-4'
