#
# Options
#

# Set prompt options
typeset -ga zopts_prompt=(
  PROMPT_SUBST   # Substitute environment variables in prompt variables.
)
setopt $zopts_prompt

#
# Init
#

fpath=(${0:A:h}/functions $fpath)
autoload -Uz $fpath[1]/*(.:t)

autoload -Uz promptinit && promptinit

zstyle -s ':zshzoo:plugin:prompt' theme 'theme_name' ||
  theme_name=${ZSH_THEME:-pure}

prompt $theme_name

unset theme_name

# vim: ft=zsh
