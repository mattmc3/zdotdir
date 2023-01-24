if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LANG='en_US.UTF-8'

# ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

export LESS='-g -i -M -R -S -w -z-4'

# Use `< file` to quickly view the contents of any file.
READNULLCMD=$PAGER

# vim: ft=zsh
