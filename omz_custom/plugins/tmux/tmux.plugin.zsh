# tmux sucks at modern and uses -f instead of knowing about XDG
if [[ -z "$XDG_CONFIG_HOME" ]]; then
  export TMUX_CONFIG="$HOME"/.tmux.conf
else
  export TMUX_CONFIG="$XDG_CONFIG_HOME"/tmux/tmux.conf
fi
alias tmux='tmux -f "$TMUX_CONFIG"'
