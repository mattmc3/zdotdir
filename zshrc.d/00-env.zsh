# set zsh to not clutter our home directory
export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

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
  /opt/homebrew/{bin,sbin}
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
)

# ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# dotfiles
[[ -d "$HOME/.config/dotfiles" ]] && export DOTFILES="$HOME/.config/dotfiles"

### Less (https://github.com/sorin-ionescu/prezto/blob/b7a80d99a84e718f30a076b27b090d3e998ad135/runcoms/zprofile#L50-L63)
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
