# ~/.zshenv only needs to source this file:
# echo "source \$HOME/.config/zsh/.zshenv" >| ~/.zshenv

export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# Set XDG dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_RUNTIME_DIR=$HOME/.xdg

export DOTFILES=$HOME/.dotfiles
