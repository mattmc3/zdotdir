# make the functions directory work like fish
fpath=("$ZDOTDIR"/functions $fpath);
autoload -U "$ZDOTDIR"/functions/*(.:t)
