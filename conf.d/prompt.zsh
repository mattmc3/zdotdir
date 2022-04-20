# setopt PROMPT_SUBST  # expand parameters in prompt variables

# autoload -Uz promptinit && promptinit
# prompt pure

# # show exit code on right
# precmd_pipestatus() {
#   local exitcodes="${(j.|.)pipestatus}"
#   if [[ "$exitcodes" != "0" ]]; then
#     RPROMPT="%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f"
#   else
#     RPROMPT=
#   fi
# }
# add-zsh-hook precmd precmd_pipestatus

# https://unix.stackexchange.com/questions/685666/zsh-how-do-i-remove-block-prefixes-when-writing-multi-line-statements-in-intera
# use 2 space indent for each new level
PS2='${${${(%):-%_}//[^ ]}// /  }    '

# # https://github.com/romkatv/zsh4humans/issues/10
# function backward-delete-char-or-up-line {
#   emulate -L zsh
#   if [[ -n "${LBUFFER}" ]]; then
#     zle backward-delete-char
#   elif [[ -n "${PREBUFFER}" ]]; then
#     local len=$(( ${#PREBUFFER} -1 ))
#     # Based on /usr/share/zsh/functions/Zle/edit-command-line
#     print -Rz - "${PREBUFFER:0:${len}}"
#     zle send-break
#   fi
# }
# zle -N backward-delete-char-or-up-line
# bindkey '^?' backward-delete-char-or-up-line

# function backward-delete-word-multiline {
#   emulate -L zsh
#   if [[ -n "${LBUFFER}" ]]; then
#     local len=${#LBUFFER}
#     if [[ "${LBUFFER:$((len-1)):${len}}" == $'\n' ]]; then
#       zle backward-delete-char
#     fi
#     zle backward-delete-word
#   elif [[ -n "${PREBUFFER}" ]]; then
#     local len=${#PREBUFFER}
#     # Based on /usr/share/zsh/functions/Zle/edit-command-line
#     print -Rz - "${PREBUFFER:0:${$((len-1))}}"
#     # send-break is required to break from a multiline editing mode.
#     zle send-break
#   fi
# }
# zle -N backward-delete-word-multiline
# bindkey '^W' backward-delete-word-multiline
