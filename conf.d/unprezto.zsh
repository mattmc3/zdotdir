#
# unprezto - Undo things Prezto did that I don't like
#

# Editor
setopt NO_BEEP

# History
setopt NO_HIST_BEEP

# Directory
setopt NO_AUTO_CD
if (( $+aliases[d] )); then
  unalias d
  alias dirh='dirs -v'
fi
