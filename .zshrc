# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# zsh options
setopt extended_glob

# zstyles
[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

# Autoload funcdir and subdirs.
for funcdir in $ZDOTDIR/functions $ZDOTDIR/functions/*(N/); do
  fpath=($funcdir $fpath)
  autoload -Uz $fpath[1]/*(.:t)
done
unset funcdir

#region antidote

ANTIDOTE_HOME=$ZDOTDIR/plugins/.external

# Clone antidote if necessary.
[[ -e $ZDOTDIR/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

# Generate a static plugin file.
zsh_plugins=$ZDOTDIR/.zplugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins} ]]; then
  (
    source $ZDOTDIR/.antidote/antidote.zsh
    envsubst <${zsh_plugins} | antidote bundle >${zsh_plugins}.zsh
  )
fi

# source the static plugins file
source ${zsh_plugins}.zsh

#endregion

# local settings/overrides
[[ -f $ZDOTDIR/.zshrc_local ]] && $ZDOTDIR/.zshrc_local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
true

# vim: ft=zsh
