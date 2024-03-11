#
# .zshrc - Run on interactive Zsh session.
#

# load lib
ZSH_CUSTOM=$ZDOTDIR
for _zrcfile in $ZDOTDIR/lib/*.zsh; do
  source $_zrcfile
done
unset _zrcfile

# Set prompt.
# mypromptint

# Run post zshrc at the very end.
zshrc-post

# Always succeed.
true

# vim: ft=zsh sw=2 ts=2 et
