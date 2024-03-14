#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Load all the kickstart.zsh libs.
for _zrc in ~/.zsh/lib/*.zsh; source $_zrc; unset _zrc

# Add stuff here...
# ...

# Run post zshrc at the very end.
zshrc-post
