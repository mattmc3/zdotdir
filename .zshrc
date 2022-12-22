# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# zsh options
setopt extended_glob

() {
  # Use a zsh home other than $HOME.
  local zhome=${ZDOTDIR:-${XDG_CONFIG_HOME:-~/.config}/zsh}

  # Autoload functions dir.
  export ZFUNCDIR=$zhome/functions
  [[ -d $ZFUNCDIR ]] || mkdir -p $ZFUNCDIR
  fpath=($ZFUNCDIR $fpath)
  autoload -Uz autoload-dir
  autoload-dir $ZFUNCDIR

  # Allow user completions.
  fpath=($zhome/completions(-/FN) $fpath)

  # conf.d
  local rcfile
  for rcfile in $zhome/conf.d/*.zsh(.N); do
    [[ ${rcfile:t} != '~'* ]] || continue
    source "$rcfile"
  done
}

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
