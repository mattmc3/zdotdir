#
# .zshrc - Run on interactive Zsh session.
#

# Allow profiling.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# add completions dir
fpath=($fpath $ZDOTDIR/completions(/FN))

myutils=(
  romkatv/zsh-bench
)

myprompts=(
  sindresorhus/pure
)

myplugins=(
  git
  homebrew
  python
  xdg
  mattmc3/zman
  rupa/z
  ohmyzsh/ohmyzsh/plugins/magic-enter
  ohmyzsh/ohmyzsh/plugins/fancy-ctrl-z
  zshzoo/editor
  zshzoo/macos
  $ZDOTDIR/lib/zebrafish.zsh

  # deferred
  romkatv/zsh-defer
  olets/zsh-abbr
  zsh-users/zsh-autosuggestions
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-history-substring-search
)

# antidote.lite
source $ZDOTDIR/lib/antidote.lite.zsh
plugin-clone $myutils $myprompts $myplugins
plugin-load --kind path $myutils
plugin-load --kind fpath $myprompts
plugin-load $myplugins

# prompt
prompt pure

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC

# vim: ft=zsh sw=2 ts=2 et
