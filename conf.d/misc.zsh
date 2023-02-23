#
# misc - Set general Zsh config options here, or change plugin settings.
#


#
# Options
#

# Fix/reset bad plugin options.
setopt NO_BEEP       # Be quiet!
setopt NO_HIST_BEEP  # Be quiet!


#
# antidote
#

[[ -n "$ANTIDOTE_HOME" ]] || ANTIDOTE_HOME="$(antidote home)"
