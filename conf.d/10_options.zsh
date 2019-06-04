# completions
setopt ALWAYS_TO_END
setopt COMPLETE_IN_WORD

# changing directories
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# I/O
# Allow comments even in interactive shells.
setopt INTERACTIVE_COMMENTS
setopt NO_FLOW_CONTROL

# job control
# Print job notifications in the long format by default.
setopt LONG_LIST_JOBS

# prompting
setopt PROMPT_SUBST

# zle
setopt EMACS
setopt NO_BEEP  # QUIET!

# history
SAVEHIST="${SAVEHIST:-100000}"
HISTSIZE="${HISTSIZE:-100000}"
HIST_STAMPS="${HIST_STAMPS:-yyyy-mm-dd}"  # https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/history.zsh
HISTFILE="$HOME/.zsh_history"

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
