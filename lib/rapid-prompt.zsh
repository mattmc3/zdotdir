#!/usr/bin/env zsh
# rapid-prompt.zsh
#
# Draw the prompt before the rest of your .zshrc runs, then replace it once
# everything has loaded. Startup does the same work, it just stops making you
# wait to see something.
#
# At the very top of .zshrc:
#   source /path/to/rapid-prompt.zsh
#   rapid_prompt z1
#
# And at the very bottom, so the drawn prompt survives the rest of startup:
#   rapid_prompt_post
#
# By default the theme is loaded first and its own prompt is drawn, so what you
# see is what you get, with nothing to keep in sync. That costs a couple of
# milliseconds, which is the right trade for most themes.
#
# For a theme too slow to load up front, powerlevel10k and starship among them,
# -p draws an approximation immediately and loads the theme behind it:
#   rapid_prompt -p '%~ %# ' powerlevel10k
#
# Anything printed during startup lands over the drawn prompt and is erased with
# it, so load noisy plugins before this or keep them quiet.
#
# The technique is romkatv's, from
# https://gist.github.com/romkatv/8b318a610dc302bdbe1487bb1847ad99

autoload -Uz add-zsh-hook promptinit

rapid_prompt() {
  emulate -L zsh
  # prompt_subst so `print -P` expands the parameters a theme's PS1 is built
  # from. emulate turns it off, and PS1 is mostly parameters.
  setopt local_options prompt_subst

  local loading= approximate=0
  while [[ $1 == -* ]]; do
    case $1 in
      -p) loading=$2; approximate=1; shift 2 ;;
      --) shift; break ;;
      *)  return 1 ;;
    esac
  done

  local theme=$1
  [[ -n $theme ]] || return 1
  shift

  # Drawing needs an interactive shell on a terminal that can save, restore and
  # erase. Without all of that, just set the theme the ordinary way.
  if [[ ! -o interactive || ! -o zle || ! -t 1 ]] ||
     ! zmodload zsh/terminfo 2>/dev/null ||
     (( ! (${+terminfo[sc]} && ${+terminfo[rc]} && ${+terminfo[ed]} && ${+terminfo[cuu]}) )); then
    promptinit
    prompt $theme "$@"
    return 0
  fi

  # Scroll now, before saving, so the saved position stays valid even when the
  # prompt lands at the bottom of the screen.
  print -n -- ${(pl.10..\n.)}
  echoti cuu 10
  echoti sc

  if (( approximate )); then
    print -Pnr -- $loading
    promptinit
    prompt $theme "$@"
  else
    promptinit
    prompt $theme "$@"

    # The theme's precmd is what fills in the parts of PS1 that change, so run
    # it once before drawing. It runs again for the real prompt, which is the
    # price of not having a second prompt definition to maintain.
    (( $+functions[prompt_${theme}_precmd] )) && prompt_${theme}_precmd
    print -Pnr -- $PS1
  fi

  add-zsh-hook precmd _rapid_prompt_clear
}

# Move the cleanup last, so the drawn prompt is not erased before the real
# prompt is ready to replace it.
rapid_prompt_post() {
  emulate -L zsh
  (( ${precmd_functions[(I)_rapid_prompt_clear]} )) || return 0
  precmd_functions=(${precmd_functions:#_rapid_prompt_clear} _rapid_prompt_clear)
}

_rapid_prompt_clear() {
  emulate -L zsh
  add-zsh-hook -d precmd _rapid_prompt_clear

  # Back to where the drawn prompt started, and wipe from there down.
  print -rn -- ${terminfo[rc]}${terminfo[sgr0]}${terminfo[ed]}
  unfunction _rapid_prompt_clear
}
