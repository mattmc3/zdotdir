# https://wezfurlong.org/wezterm/shell-integration.html
# https://github.com/wez/wezterm/blob/main/assets/shell-integration/wezterm.sh

[[ "${TERM_PROGRAM:l}" == "wezterm" ]] || return 1

source "$ZDOTDIR/lib/wezterm-shell-integration.sh"

function set_current_shell() {
  __wezterm_set_user_var "TERM_CURRENT_SHELL" "zsh ${${ZSH_PATCHLEVEL:-$ZSH_VERSION}#zsh-}"
}
set_current_shell
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_current_shell
