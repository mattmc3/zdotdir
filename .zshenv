# ~/.zshenv should only be a one-liner that sources this file
# echo ". ~/.config/zsh/.zshenv" >| ~/.zshenv

# This file sources the same environment file .zshrc does
[[ ! -f ~/.config/zsh/zshrc.d/00-env.zsh ]] ||
      . ~/.config/zsh/zshrc.d/00-env.zsh
