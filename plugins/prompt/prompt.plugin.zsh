#
# Set zsh prompt.
#

#
# Options
#

setopt PROMPT_SUBST  # Expand parameters in prompt.

#
# Variables
#

ZSH_PROMPT=${ZSH_PROMPT:-pure}
fpath=(
  $ZPLUGINDIR/.external/pure
  $ZPLUGINDIR/.external/powerlevel10k
  $fpath
)

# https://unix.stackexchange.com/questions/685666/zsh-how-do-i-remove-block-prefixes-when-writing-multi-line-statements-in-intera
# use 2 space indent for each new level
PS2='${${${(%):-%_}//[^ ]}// /  }    '

#
# Init
#

# configure prompt
if [[ $ZSH_PROMPT == pure ]]; then
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

elif [[ $ZSH_PROMPT == p10k ]]; then
  source ${0:A:h}/p10k.zsh
fi

# set prompt
autoload -Uz promptinit && promptinit
[[ -z "$ZSH_PROMPT" ]] || prompt $ZSH_PROMPT
