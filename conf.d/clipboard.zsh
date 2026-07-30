#
# Clipboard utilities
#

[[ "$TERM" != dumb ]] || return 1

if ! (( $+commands[pbcopy] || $+functions[pbcopy] || $+aliases[pbcopy] )); then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias pbcopy='tee > /dev/clipboard'
    alias pbpaste='cat /dev/clipboard'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias pbcopy='termux-clipboard-set'
    alias pbpaste='termux-clipboard-get'
  elif (( $+commands[wl-copy] && $+commands[wl-paste] )); then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  elif [[ -n $DISPLAY ]]; then
    if (( $+commands[xclip] )); then
      alias pbcopy='xclip -selection clipboard -in'
      alias pbpaste='xclip -selection clipboard -out'
    elif (( $+commands[xsel] )); then
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'
    fi
  fi
fi

copyfile() {
  emulate -L zsh

  if [[ -z $1 ]]; then
    print -ru2 "Usage: copyfile <file>"
    return 1
  fi

  if [[ ! -f $1 ]]; then
    print -ru2 "Error: '$1' is not a valid file."
    return 1
  fi

  pbcopy < "$1"
  print ${(%):-"%B$1%b copied to clipboard."}
}

copypath() {
  local file=${1:-.}
  [[ $file == /* ]] || file="$PWD/$file"

  print -n "${file:a}" | pbcopy || return 1
  print ${(%):-"%B${file:a}%b copied to clipboard."}
}

copybuffer() {
  if (( $+commands[pbcopy] || $+aliases[pbcopy] || $+functions[pbcopy] )); then
    print -n "$BUFFER" | pbcopy
  else
    zle -M "pbcopy not found. Please make sure it is available in your shell."
  fi
}
zle -N copybuffer

bindkey -M emacs '^O' copybuffer
bindkey -M viins '^O' copybuffer
bindkey -M vicmd '^O' copybuffer
