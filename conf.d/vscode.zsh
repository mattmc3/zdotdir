#
# vscode
#

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  # https://code.visualstudio.com/docs/terminal/shell-integration
  source "$(code --locate-shell-integration-path zsh)"
fi
