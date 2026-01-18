# rapid-prompt.zsh
#
# Generic rapid prompt for promptinit themes.
#
# Usage:
#   source /path/to/rapid-prompt.zsh
#   rapid_prompt <theme> [theme-args...]
#
# Example:
#   rapid_prompt starship minimal
#   rapid_prompt pure

autoload -Uz add-zsh-hook add-zle-hook-widget promptinit

rapid_prompt() {
  emulate -L zsh

  # Only in interactive shells with a real TTY.
  [[ -t 0 && -t 1 && -t 2 && -o interactive && -o zle && -o no_xtrace ]] || return 0

  local theme=${1-}
  shift || true
  [[ -n $theme ]] || return 0

  # Save requested theme so we can apply it later automatically.
  typeset -gH _rapid_prompt_theme=$theme
  typeset -gaH _rapid_prompt_args
  _rapid_prompt_args=("$@")

  # Terminal capabilities required.
  zmodload zsh/terminfo 2>/dev/null || return 0
  (( ${+terminfo[sc]} && ${+terminfo[rc]} && ${+terminfo[ed]} )) || return 0

  # Hide cursor (polish).
  (( ${+terminfo[civis]} )) && echoti civis

  # Save cursor position.
  echoti sc

  # One-shot precmd cleanup.
  add-zsh-hook precmd _rapid_prompt_precmd

  # Capture stderr during early init so warnings don't corrupt the drawn prompt.
  typeset -gHi _rapid_prompt_fd=-1
  typeset -gH _rapid_prompt_tmp==( <<< '' )
  exec {_rapid_prompt_fd}>&2
  exec 2> $_rapid_prompt_tmp

  # Initialize prompt system and load theme now.
  promptinit
  prompt "$theme" "$@"

  # Save cursor position again in case theme setup moved it.
  echoti sc

  # If the theme has a precmd, run it once so PS1/RPS1 are populated.
  local fn="prompt_${theme}_precmd"
  if (( $+functions[$fn] )); then
    $fn

    # Prevent it from running twice before the first real prompt.
    functions[:rapid:$fn]=$functions[$fn]
    eval "$fn() {
      functions[$fn]=\$functions[:rapid:$fn]
      unfunction :rapid:$fn
    }"
  fi

  # Disable prompt spacing temporarily while we manually draw.
  setopt no_promptsp

  # Draw prompt NOW.
  if [[ ${PWD-} == *ZB<->-cwd* || ${PWD-} == */zsh-bench-*/* ]]; then
    # include PWD so zsh-bench knows we've rendered a prompt
    print -nPr -- $'\r'"$PWD $PS1"
  else
    print -nPr -- "%$COLUMNS<<${(l:$COLUMNS:: :)}$RPS1"
    print -nPr -- $'\r'"$PS1"
  fi

  # Restore cursor visibility.
  (( ${+terminfo[cnorm]} )) && echoti cnorm

  return 0
}

_rapid_prompt_precmd() {
  emulate -L zsh

  # One-shot: remove ourselves.
  add-zsh-hook -d precmd ${(%):-%N}

  zmodload zsh/terminfo 2>/dev/null || return 0

  # Hide cursor while cleaning up.
  (( ${+terminfo[civis]} )) && echoti civis

  # Restore cursor to where rapid prompt was printed.
  echoti rc

  # Restore stderr and print captured error output above the prompt.
  if [[ -n ${_rapid_prompt_fd-} && -n ${_rapid_prompt_tmp-} ]]; then
    exec 2>&$_rapid_prompt_fd
    local err
    err="$( < $_rapid_prompt_tmp )"
    [[ -n $err ]] && print -u2 -- "$err"
    unset _rapid_prompt_fd _rapid_prompt_tmp
  fi

  # Apply the real prompt theme automatically (so user doesn't need to).
  if [[ -n ${_rapid_prompt_theme-} ]]; then
    promptinit
    prompt "$_rapid_prompt_theme" "${_rapid_prompt_args[@]}"

    # If the theme defines a precmd, allow it to run normally from now on.
    # (We don't call it here; Zsh will run precmd functions as usual.)
  fi

  # Ensure cursor visible again.
  (( ${+terminfo[cnorm]} )) && echoti cnorm

  # Restore prompt spacing on first interactive line init.
  add-zle-hook-widget line-init _rapid_prompt_line_init

  return 0
}

_rapid_prompt_line_init() {
  emulate -L zsh

  # One-shot: remove ourselves.
  add-zle-hook-widget -d line-init ${(%):-%N}

  zmodload zsh/terminfo 2>/dev/null || return 0
  (( ${+terminfo[cnorm]} )) && echoti cnorm

  # Restore prompt spacing if the user hasn't explicitly configured prompt_opts.
  [[ -v prompt_opts ]] || setopt promptsp

  return 0
}
