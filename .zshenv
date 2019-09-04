# ~/.zshenv needs to source this file and can be created with this
# echo "source ~/.zsh/.zshenv > ~/.zshenv"

# ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}; ln -s $ZDOTDIR/.zshenv ~/.zshenv

export ZDOTDIR=$HOME/.zsh

export DOTFILES="$HOME/.config/dotfiles"

source $ZDOTDIR/xdg.zsh
