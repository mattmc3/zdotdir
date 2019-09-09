# ~/.zshenv needs to source this file and can be created with this
# echo "source ~/.zsh/.zshenv > ~/.zshenv"

# ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}; ln -s $ZDOTDIR/.zshenv ~/.zshenv

export ZDOTDIR=$HOME/.config/zsh
export DOTFILES="$HOME/.config/dotfiles"
source $ZDOTDIR/xdg.sh
