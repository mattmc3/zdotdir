#
# pure - sindresorhus/pure prompt
#
(( $+functions[prompt_pure_preexec] )) || return 1

# Pure prompt symbol
PURE_PROMPT_SYMBOL="%%"

# show exit code on right
function precmd_pipestatus {
  local exitcodes="${(j.|.)pipestatus}"
  if [[ "$exitcodes" != "0" ]]; then
    RPROMPT="%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f"
  else
    RPROMPT=
  fi
}
add-zsh-hook precmd precmd_pipestatus
