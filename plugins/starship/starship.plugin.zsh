#
# prompt
#

# Load plugin completions.
fpath=(${0:A:h}/completions $fpath)

# Load starship prompt.
if [[ -f $ZDOTDIR/themes/zsh.toml ]]; then
  export STARSHIP_CONFIG=$ZDOTDIR/themes/zsh.toml
fi
eval "$(starship init zsh)"
