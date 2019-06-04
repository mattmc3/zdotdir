# tmux -------------------------------------------------------------------------
# re-home app configs to ~/.config
# tmux sucks at modern and uses -f instead of knowing about XDG
export TMUX_HOME="$DOTFILES"/tmux/tmux.conf
alias tmux='tmux -f "$TMUX_HOME"'
