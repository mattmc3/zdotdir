# Coloured man page support
# using 'less' env vars (format is '\E[<brightness>;<color>m')
export LESS_TERMCAP_mb=$'\E[01;94m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;94m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[04;35m'      # Begins underline.
