SAVEHIST="${SAVEHIST:-50000}"
HISTSIZE="${HISTSIZE:-50000}"
HIST_STAMPS="${HIST_STAMPS:-yyyy-mm-dd}"  # https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/history.zsh

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt no_hist_beep
setopt share_history
