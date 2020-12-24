PURE_PROMPT_SYMBOL="%%"

# [[ -d "$ZDOTDIR/plugins/pure" ]] ||
#   git clone https://github.com/sindresorhus/pure.git "$ZDOTDIR/plugins/pure"
# fpath+="$ZDOTDIR/plugins/pure"
# autoload -U promptinit; promptinit
# prompt pure

[[ -d "$ZDOTDIR/plugins/pure" ]] ||
  plugin clone sindresorhus/pure

if [[ $ZPROF != true ]]; then
  plugin prompt pure
else
  fpath+="$ZDOTDIR/plugins/pure"
  autoload -U promptinit; promptinit
  prompt pure
fi
