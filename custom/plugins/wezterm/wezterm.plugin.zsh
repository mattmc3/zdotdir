# https://wezfurlong.org/wezterm/shell-integration.html
# https://github.com/wez/wezterm/blob/main/assets/shell-integration/wezterm.sh

0=${(%):-%N}
source "${0:A:h}/wezterm-shell-integration.sh"

function set_current_shell_precmd() {
  __wezterm_set_user_var "TERM_CURRENT_SHELL" "zsh ${${ZSH_PATCHLEVEL:-$ZSH_VERSION}#zsh-}"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_current_shell_precmd
