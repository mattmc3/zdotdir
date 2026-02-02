# Terminal

case "${TERM_PROGRAM:l}" in
  apple_terminal)
    export SHELL_SESSIONS_DISABLE=1
    ;;
  ghostty)
    source ${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration
    ;;
  vscode)
    # https://code.visualstudio.com/docs/terminal/shell-integration
    MY_HISTFILE=${HISTFILE:-${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history}
    source "$(code --locate-shell-integration-path zsh)"
    HISTFILE=$MY_HISTFILE
    #unset MY_HISTFILE
    ;;
  wezterm)
    source "$ZDOTDIR/lib/wezterm-shell-integration.sh"
    function set_current_shell() {
      __wezterm_set_user_var "TERM_CURRENT_SHELL" "zsh ${${ZSH_PATCHLEVEL:-$ZSH_VERSION}#zsh-}"
    }
    set_current_shell
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd set_current_shell
    ;;
esac
