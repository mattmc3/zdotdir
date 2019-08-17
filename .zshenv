# ~/.zshenv needs to source this file and can be created with this
# echo "source ~/.zsh/.zshenv > ~/.zshenv"

# ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}; ln -s $ZDOTDIR/.zshenv ~/.zshenv

export ZDOTDIR=$HOME/.zsh

# Make sure XDG dirs are set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"

#
# todo.sh (todo.txt)
#
if command -v todo.sh &> /dev/null; then
  export TODOTXT_CFG_FILE="$XDG_CONFIG_HOME"/todo-txt/config
  if [[ ! -f "$TODOTXT_CFG_FILE" ]]; then
    mkdir -p $( dirname "$TODOTXT_CFG_FILE" )
    touch "$TODOTXT_CFG_FILE"
  fi
fi

#
# z
#
if command -v z &> /dev/null; then
  export _Z_DATA="$XDG_DATA_HOME/z/data"
  if [[ ! -f "$_Z_DATA" ]]; then
    mkdir -p $( dirname "$_Z_DATA" )
    touch "$_Z_DATA"
  fi
fi
