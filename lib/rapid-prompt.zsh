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
# Anything printed during startup, direnv and errors included, is captured and
# replayed above the real prompt once loading finishes.
RAPID_PROMPT_VERSION="1.0.1"
autoload -Uz add-zsh-hook promptinit
zmodload -F zsh/files b:zf_rm 2>/dev/null

rapid_prompt() {
  _rapid_prompt_main "$@" || return
  (( ${precmd_functions[(I)_rapid_prompt_clear]} )) || return 0

  # The drawn prompt leaves the cursor mid-line, and zsh would stamp a
  # PROMPT_EOL_MARK over it ahead of the first precmd. Suspend prompt_cr and
  # prompt_sp until the clear. That must outlive this function, which is why
  # it happens out here instead of under the emulate in _rapid_prompt_main.
  # The scroll before drawing keeps any partial line from a previous program
  # visible, which is most of what prompt_sp is for.
  typeset -ga _rapid_prompt_opts=()
  [[ -o prompt_cr ]] && _rapid_prompt_opts+=(prompt_cr)
  [[ -o prompt_sp ]] && _rapid_prompt_opts+=(prompt_sp)
  unsetopt localoptions prompt_cr prompt_sp
}

_rapid_prompt_main() {
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
    _rapid_prompt_capture
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
    _rapid_prompt_capture
  fi

  add-zsh-hook precmd _rapid_prompt_clear
}

# Send startup output to a log so it can be replayed above the real prompt,
# instead of landing over the drawn prompt and being erased with it.
_rapid_prompt_capture() {
  emulate -L zsh
  typeset -g _rapid_prompt_log=${XDG_CACHE_HOME:-$HOME/.cache}/rapid-prompt.$$
  { : >| $_rapid_prompt_log } 2>/dev/null || { unset _rapid_prompt_log; return 0 }
  exec {_rapid_prompt_fd1}>&1 {_rapid_prompt_fd2}>&2 >>$_rapid_prompt_log 2>&1
}

# Move the cleanup last, so the drawn prompt is not erased before the real
# prompt is ready to replace it.
rapid_prompt_post() {
  emulate -L zsh
  (( ${precmd_functions[(I)_rapid_prompt_clear]} )) || return 0
  precmd_functions=(${precmd_functions:#_rapid_prompt_clear} _rapid_prompt_clear)
}

_rapid_prompt_clear() {
  # Put prompt_cr and prompt_sp back out here. Options set under an emulate
  # -L roll back to their function-entry state on return, so the emulate
  # lives in an inner function and the restore stays outside it.
  (( ${#_rapid_prompt_opts[@]} )) && setopt -- "${_rapid_prompt_opts[@]}"

  () {
    emulate -L zsh
    add-zsh-hook -d precmd _rapid_prompt_clear

    if (( ${+_rapid_prompt_fd1} )); then
      exec 1>&$_rapid_prompt_fd1 2>&$_rapid_prompt_fd2 \
          {_rapid_prompt_fd1}>&- {_rapid_prompt_fd2}>&-
    fi

    # Back to where the drawn prompt started, wipe from there down, and lay
    # the replayed startup output in its place. One write, bracketed by
    # synchronized-update marks, so the terminal never paints the blank
    # in-between state. The real prompt then lands below the replay.
    local replay=
    [[ -n $_rapid_prompt_log && -s $_rapid_prompt_log ]] &&
      replay="$(<$_rapid_prompt_log)"$'\n'
    print -rn -- $'\e[?2026h'${terminfo[rc]}${terminfo[sgr0]}${terminfo[ed]}${replay}$'\e[?2026l'

    if [[ -n $_rapid_prompt_log ]]; then
      if (( $+builtins[zf_rm] )); then
        zf_rm -f -- $_rapid_prompt_log
      else
        command rm -f -- $_rapid_prompt_log
      fi
    fi

    unset _rapid_prompt_log _rapid_prompt_fd1 _rapid_prompt_fd2 _rapid_prompt_opts
    unfunction _rapid_prompt_clear
  }
}
