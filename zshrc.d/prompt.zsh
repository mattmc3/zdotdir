### Pure prompt (https://github.com/sindresorhus/pure)
# create a patch by changing the code (no need to commit)
# and then running this command
# $ git diff > some-changes.patch

if [[ -d $ZDOTDIR/plugins/pure ]] &&
   [[ -f $ZDOTDIR/misc/pure-less-spacious.patch ]] &&
   [[ ! -f $ZDOTDIR/plugins/pure/pure-less-spacious.patch ]]
then
  cp $ZDOTDIR/misc/pure-less-spacious.patch $ZDOTDIR/plugins/pure
  echo "Patching pure prompt..."
  git -C "$ZDOTDIR/plugins/pure" apply $ZDOTDIR/plugins/pure/pure-less-spacious.patch
fi

### Starship prompt
# command -v starship &>/dev/null || sh -c "$(curl -fsSL https://starship.rs/install.sh)"
# export STARSHIP_CONFIG=~/.config/starship/zsh.toml
# eval "$(starship init zsh)"
