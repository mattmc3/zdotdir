0=${(%):-%x}

setopt PROMPT_SUBST
autoload -Uz promptinit && promptinit

ZSH_THEME=p10k

if [[ $ZSH_THEME == pure ]]; then
  # expand parameters in prompt variables
  prompt pure

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

elif [[ $ZSH_THEME == p10k ]]; then
  prompt powerlevel10k
  source ${0:A:h}/p10k.zsh

else
  prompt $ZSH_THEME
fi

# https://unix.stackexchange.com/questions/685666/zsh-how-do-i-remove-block-prefixes-when-writing-multi-line-statements-in-intera
# use 2 space indent for each new level
PS2='${${${(%):-%_}//[^ ]}// /  }    '
