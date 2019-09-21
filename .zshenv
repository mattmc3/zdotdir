# ~/.zshenv needs to source this file and can be created with this
# echo "source ~/.zsh/.zshenv > ~/.zshenv"

# ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}; ln -s $ZDOTDIR/.zshenv ~/.zshenv

export ZDOTDIR=$HOME/.config/zsh

# Set XDG dirs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"

[[ -d "$HOME/.config/dotfiles" ]] && export DOTFILES="$HOME/.config/dotfiles"
