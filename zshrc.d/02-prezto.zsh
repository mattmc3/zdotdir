# set prezto variables
ZPREZTODIR=$ZDOTDIR/.zprezto
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"

if [[ ! -d $ZPREZTODIR ]]; then
  echo "Cloning prezto"
  git clone --quiet --recursive --depth 1 https://github.com/sorin-ionescu/prezto $ZPREZTODIR
fi

# load prezto
source "$ZPREZTODIR/init.zsh"
