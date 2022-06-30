export DOTFILES=~/.config/dotfiles
export DOTFILES_LOCAL=~/.config/dotfiles.local

# uncomment if dotfiles are managed with a bare repo
# alias dotf='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# comment if using bare repo
alias dotf='cd "$DOTFILES"'
alias dotfed='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'

if [[ ! -d $DOTFILES_LOCAL ]]; then
  git clone git@github.com:mattmc3/dotfiles.local $DOTFILES_LOCAL
fi
if [[ ! -e $ZDOTDIR/.zshrc.local ]]; then
  ln -sf $DOTFILES_LOCAL/zsh/zshrc_local.zsh $ZDOTDIR/.zshrc.local
fi
