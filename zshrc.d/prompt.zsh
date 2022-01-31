# prezto sorin prompt
# zstyle ':prezto:module:editor:info:keymap:primary' format ' %F{5}%%%f'

### pure prompt (https://github.com/sindresorhus/pure)
# create a patch by changing the code (no need to commit)
# and then running this command
# $ git diff > some-changes.patch
if [[ -d $ZPLUGINDIR/pure ]] &&
   [[ -f $ZDOTDIR/patches/pure-less-spacious.patch ]] &&
   [[ ! -f $ZPLUGINDIR/pure/pure-less-spacious.patch ]]
then
  cp $ZDOTDIR/patches/pure-less-spacious.patch $ZPLUGINDIR/pure
  echo "Patching pure prompt..."
  git -C "$ZPLUGINDIR/pure" apply $ZPLUGINDIR/pure/pure-less-spacious.patch
fi
PURE_PROMPT_SYMBOL="%%"

# show exit code on right
precmd_pipestatus() {
  local exitcodes="${(j.|.)pipestatus}"
  if [[ "$exitcodes" != "0" ]]; then
    RPROMPT="%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f"
  else
    RPROMPT=
  fi
}
add-zsh-hook precmd precmd_pipestatus

### Starship prompt
# command -v starship &>/dev/null || sh -c "$(curl -fsSL https://starship.rs/install.sh)"
# export STARSHIP_CONFIG=~/.config/starship/zsh.toml
# eval "$(starship init zsh)"

# autoload -U promptinit && promptinit

# general
# https://unix.stackexchange.com/questions/685666/zsh-how-do-i-remove-block-prefixes-when-writing-multi-line-statements-in-intera
# use 2 space indent for each new level
PS2='${${${(%):-%_}//[^ ]}// /  }    '
