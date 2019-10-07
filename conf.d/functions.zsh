### functions -------------------------------------------------------------- {{{
# make the zfunctions directory work like fish
if [[ -n $ZDOTDIR ]]; then
  fpath=("$ZDOTDIR"/zfunctions $fpath);
  autoload -U "$ZDOTDIR"/zfunctions/*(.:t)
else
  fpath=("$HOME"/.zfunctions $fpath);
  autoload -U "$HOME"/.zfunctions/*(.:t)
fi

# 'ls' after 'cd'
function chpwd_cdls() {
  emulate -L zsh
  \ls -FG
}
chpwd_functions+=(chpwd_cdls)
