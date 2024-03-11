#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Load everything in lib
ZSH_CUSTOM=$ZDOTDIR
for _zrcfile in $ZDOTDIR/lib/*.zsh; do
  source $_zrcfile
done
unset _zrcfile

# Add stuff here...
# ...

# Run post zshrc at the very end.
zshrc-post

# Always succeed.
true
