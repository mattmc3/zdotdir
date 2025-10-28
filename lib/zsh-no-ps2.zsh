#!/usr/bin/env zsh

# https://github.com/romkatv/zsh-no-ps2
function zsh-no-ps2 {
  setopt local_options no_err_return no_err_exit

  # Succeeds if $1 is a well-formed command.
  () {
    # If it ends with an odd number of backslashes, it's malformed.
    () {
      builtin emulate -L zsh -o extended_glob
      [[ $1 == (|*[^\\])(\\\\)#\\ ]]
    } "$1" && builtin return 1

    if [[ -v functions[-zsh-no-ps2-test] ]]; then
      builtin unfunction -- -zsh-no-ps2-test
    fi
    functions[-zsh-no-ps2-test]="$1" 2>/dev/null              || builtin return 1
    [[ -v functions[-zsh-no-ps2-test] ]]                      || builtin return 1
    builtin unfunction -- -zsh-no-ps2-test
    # This suffix allows us to detect two tricky cases: "for x" and "<<END".
    # Each of these on their own is a valid function body but neither can
    # be executed as a command in interactive shell.
    functions[-zsh-no-ps2-test]="$1"$'\ndo\ndone' 2>/dev/null || builtin return 0
    [[ -v functions[-zsh-no-ps2-test] ]]                      || builtin return 0
    builtin unfunction -- -zsh-no-ps2-test
    builtin return 1
  } "$PREBUFFER$BUFFER"

  if (( $? )); then
    # We do it this way instead of the plain LBUFFER+=$'\n' in order
    # to make this plugin work with zsh-autosuggestions. Unfortunately, this
    # means that binding zsh-no-ps2 to anything other than Enter won't work.
    # This can be fixed: we just need to define our own widget that does
    # LBUFFER+=$'\n' and invoke it here.
    #
    # TODO: do what the above says.
    builtin zle self-insert-unmeta
  else
    builtin local w
    builtin zstyle -s :zsh-no-ps2: accept-line w || w=accept-line
    if [[ -n $w ]]; then
      builtin zle -- "$w"
    fi
  fi
}

# We make the widget's name start with a dot in order to make this plugin
# work with zsh-syntax-highlighting and zsh-autosuggestions.
builtin autoload -Uz -- "${${(%):-%x}:A:h}/zsh-no-ps2" &&
builtin zle -N .zsh-no-ps2 zsh-no-ps2                  &&
builtin bindkey '^J' .zsh-no-ps2                       &&
builtin bindkey '^M' .zsh-no-ps2
