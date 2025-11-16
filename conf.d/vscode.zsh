#
# vscode
#

if [[ "${TERM_PROGRAM:l}" == "vscode" ]]; then
  # https://code.visualstudio.com/docs/terminal/shell-integration
  MY_HISTFILE=$HISTFILE
  source "$(code --locate-shell-integration-path zsh)"
  HISTFILE=$MY_HISTFILE
  unset MY_HISTFILE
fi
