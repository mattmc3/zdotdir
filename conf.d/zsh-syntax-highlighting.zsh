#
# zsh-syntax-highlighting: Snippet to config zsh-users/zsh-syntax-highlighting
#

# See available highlighters here:
# - https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md

# Check if using zsh-users/zsh-syntax-highlighting
[[ -v ZSH_HIGHLIGHT_STYLES ]] || return 1

ZSH_HIGHLIGHT_HIGHLIGHTERS=(
  main
  brackets
  regexp
  pattern
  line
  cursor
  root
)

# Highlight subcommands (the second word) in yellow.
ZSH_HIGHLIGHT_STYLES[subcommand]='fg=yellow'

# Whenever the buffer is modified, evaluate whether there's a subcommand.
_zsh_highlight_highlighter_subcommand_predicate() {
  _zsh_highlight_buffer_modified
}

_zsh_highlight_highlighter_subcommand_paint() {
  # Short-circuit check to ensure there are multiple words.
  local -a words=(${=BUFFER})
  (( $#words > 1 )) || return

  # Find the second word
  local startpos=0 pos=0 state=start char=
  for char in ${(s..)BUFFER}; do
    case $state in
      start)
        if [[ "$char" == [[:alnum:]] ]]; then
          state=cmd
        elif [[ "$char" == '#' ]]; then
          state=comment
          break
        fi
        ;;
      cmd)
        if [[ "$char" == [[:space:]] ]]; then
          state=whitespace
        fi
      ;;
      whitespace)
        if [[ "$char" == [[:alnum:]] ]]; then
          startpos=$pos
          state=subcmd
        elif [[ "$char" != [[:space:]] ]]; then
          # If the next word begins with a non-space, non-alnum char
          # (eg: punctuation), then it's likely a --flag, $var, ~/path,
          # or something else - not a proper subcommand
          state=none
          break
        fi
      ;;
      subcmd)
        if [[ "$char" == [[:space:]] ]]; then
          break
        elif [[ "$char" != [[:alnum:]] ]] && [[ "$char" != (-|_) ]]; then
          state=none
          break
        fi
      ;;
    esac
    (( ++pos ))
  done

  if [[ "$state" == subcmd ]] && (( $startpos < $pos )); then
    _zsh_highlight_add_highlight $startpos $pos 'subcommand'
  fi
}

# Add custom subcommand highlighter
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(subcommand)

# Highlight command flags (-f|--flag).
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan

# A directory name in command position when the AUTO_CD option is set
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=blue,bold,underline"

ZSH_HIGHLIGHT_STYLES[path]=fg=magenta
ZSH_HIGHLIGHT_STYLES[default]=fg=blue

# Make rm -rf a bit more obvious.
typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS[rm*-rf*]="fg=white,bold,bg=red"
