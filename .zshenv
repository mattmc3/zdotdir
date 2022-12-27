###
# Define Zsh environment variables.
###

# Even with `$ZDOTDIR` set ~/.zshenv needs to remain.
# But, you can symlink it to this file
# ln -s ~/.config/zsh/.zshenv ~/.zshenv

export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}

# XDG
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_RUNTIME_DIR=~/.xdg

# Set editors.
export EDITOR="nvim"
export VISUAL="code"
export PAGER="less"

# Regional settings.
export TZ="America/New_York"

# Set the list of directories that cd searches
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# macOS
if [[ "$OSTYPE" == darwin* ]]; then
  export SHELL_SESSIONS_DISABLE=1
fi
