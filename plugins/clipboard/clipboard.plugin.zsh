# Define two functions, clipcopy and clippaste, based on the detected platform.
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/clipboard.zsh
#
# clipcopy - Copy data to clipboard.
#  <command> | clipcopy    - copies stdin to clipboard
#  clipcopy <file>         - copies a file's contents to clipboard
#
# clippaste - Paste data from clipboard to stdout.
#   clippaste              - writes clipboard's contents to stdout
#   clippaste | <command>  - pastes contents and pipes it to another process
#   clippaste > <file>     - paste contents to a file
#
if [[ "${OSTYPE}" == darwin* ]] && (( ${+commands[pbcopy]} )) && (( ${+commands[pbpaste]} )); then
  function clipcopy  { cat "${1:-/dev/stdin}" | pbcopy; }
  function clippaste { pbpaste; }
elif [[ "${OSTYPE}" == (cygwin|msys)* ]]; then
  function clipcopy  { cat "${1:-/dev/stdin}" > /dev/clipboard; }
  function clippaste { cat /dev/clipboard; }
elif [ -n "${WAYLAND_DISPLAY:-}" ] && (( ${+commands[wl-copy]} )) && (( ${+commands[wl-paste]} )); then
  function clipcopy  { cat "${1:-/dev/stdin}" | wl-copy &>/dev/null &|; }
  function clippaste { wl-paste; }
elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xsel]} )); then
  function clipcopy  { cat "${1:-/dev/stdin}" | xsel --clipboard --input; }
  function clippaste { xsel --clipboard --output; }
elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xclip]} )); then
  function clipcopy  { cat "${1:-/dev/stdin}" | xclip -selection clipboard -in &>/dev/null &|; }
  function clippaste { xclip -out -selection clipboard; }
elif (( ${+commands[lemonade]} )); then
  function clipcopy  { cat "${1:-/dev/stdin}" | lemonade copy; }
  function clippaste { lemonade paste; }
elif (( ${+commands[doitclient]} )); then
  function clipcopy  { cat "${1:-/dev/stdin}" | doitclient wclip; }
  function clippaste { doitclient wclip -r; }
elif (( ${+commands[win32yank]} )); then
  function clipcopy  { cat "${1:-/dev/stdin}" | win32yank -i; }
  function clippaste { win32yank -o; }
elif [[ $OSTYPE == linux-android* ]] && (( $+commands[termux-clipboard-set] )); then
  function clipcopy  { cat "${1:-/dev/stdin}" | termux-clipboard-set; }
  function clippaste { termux-clipboard-get; }
elif [ -n "${TMUX:-}" ] && (( ${+commands[tmux]} )); then
  function clipcopy  { tmux load-buffer "${1:--}"; }
  function clippaste { tmux save-buffer -; }
elif [[ $(uname -r) = *icrosoft* ]]; then
  function clipcopy  { cat "${1:-/dev/stdin}" | clip.exe; }
  function clippaste { powershell.exe -noprofile -command Get-Clipboard; }
fi

# Copies the contents of a given file to the system or X Windows clipboard.
function copyfile {
  # copyfile <file>
  emulate -L zsh
  clipcopy $1
}

# Copies the path of given directory or file to the system or X Windows clipboard.
# Copy current directory if no parameter.
function copypath {
  # If no argument passed, use current directory.
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD.
  [[ $file = /* ]] || file="$PWD/$file"

  # Copy the absolute path without resolving symlinks.
  # If clipcopy fails, exit the function with an error.
  print -n "${file:a}" | clipcopy || return 1

  echo ${(%):-"%B${file:a}%b copied to clipboard."}
}

# Copy the active line from the command line buffer onto the system clipboard.
function copybuffer {
  printf "%s" "$BUFFER" | clipcopy
}
zle -N copybuffer

# ctrl-o copies the current buffer
bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
bindkey -M vicmd "^O" copybuffer
