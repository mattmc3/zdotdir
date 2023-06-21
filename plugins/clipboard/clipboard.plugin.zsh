#
# clipboard
#

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# pbcopy/pbpaste
if ! (( $+commands[pbcopy] )); then
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

# copy the active line from the command line buffer
function copybuffer {
  printf "%s" "$BUFFER" | pbcopy
}
zle -N copybuffer

bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
bindkey -M vicmd "^O" copybuffer

function copyfile {
  emulate -L zsh
  [[ -e $1 ]] || return 1
  cat $1 | pbcopy
}

# Copy the path to clipboard or current directory if no parameter.
function copypath {
  # If no argument passed, use current directory.
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD.
  [[ $file = /* ]] || file="$PWD/$file"

  # Copy the absolute path without resolving symlinks
  # If clipcopy fails, exit the function with an error
  print -n "${file:a}" | pbcopy || return 1

  echo ${(%):-"%B${file:a}%b copied to clipboard."}
}
