#
# .zshrc
#

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Zstyle customizations
[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

# Zsh lib
for zlib in $ZDOTDIR/lib/*.zsh(.N); . $zlib

# Add lazy-load functions
ZFUNCDIR=$ZDOTDIR/functions
for zdir in $ZFUNCDIR(/FN) $ZFUNCDIR/*(/FN); do
  fpath=($zdir $fpath)
  autoload -Uz $zdir/*(.:t)
done

# clone missing repos
REPO_HOME=${XDG_CACHE_HOME:=~/.cache}/repos
[[ -d $REPO_HOME ]] || repo in <$ZDOTDIR/repos.txt

# Plugins
myplugins=(
  # load plugins
  colorize
  clipboard
  editor
  fancy-ctrl-z
  fishify
  git
  golang
  homebrew
  macos
  magic-enter
  prompt
  python
  terminal
  utility
  z
  confd
  completion

  _defer_
  syntax-highlighting
  autosuggest
  history-substring-search
)
plugin-load $myplugins

# prompt
prompt starship mmc

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# clean up
unset zlib zdir

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
