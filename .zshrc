#
# .zshrc - Run on interactive Zsh session.
#

# Allow profiling.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# add completions dir
fpath=($fpath $ZDOTDIR/completions(/FN))

# plugin driven config
myrepos=(
  mbadolato/iTerm2-Color-Schemes
)

myutils=(
  romkatv/zsh-bench
)

myprompts=(
  sindresorhus/pure
  romkatv/powerlevel10k
)

myplugins=(
  $ZDOTDIR/plugins/git
  $ZDOTDIR/plugins/homebrew
  $ZDOTDIR/plugins/python
  $ZDOTDIR/plugins/xdg
  mattmc3/zfunctions
  mattmc3/zman
  rupa/z
  ohmyzsh/ohmyzsh/plugins/extract
  ohmyzsh/ohmyzsh/plugins/magic-enter
  ohmyzsh/ohmyzsh/plugins/fancy-ctrl-z
  sorin-ionescu/prezto/modules/directory
  sorin-ionescu/prezto/modules/editor
  belak/zsh-utils/history
  belak/zsh-utils/prompt
  belak/zsh-utils/utility
  belak/zsh-utils/completion
  mattmc3/zshrc.d

  # deferred
  romkatv/zsh-defer
  olets/zsh-abbr
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
)

# antidote.lite
source $ZDOTDIR/lib/antidote.lite.zsh
plugin-clone $myrepos $myutils $myprompts $myplugins
plugin-load --kind path $myutils
plugin-load --kind fpath $myprompts
plugin-load $myplugins

# completion style
compstyle zshzoo

# prompt
prompt pure

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC

# vim: ft=zsh sw=2 ts=2 et
