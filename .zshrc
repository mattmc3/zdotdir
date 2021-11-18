# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof

# drive zsh with core libs
zlibs=(
  # opts
  # history
  xdg
  xdg-apps
  zfuncd
  zcompd
  prezto
  # compinit
  # completions
  zconfd
)
for zlib in $zlibs; do
  source $ZDOTDIR/zlib/$zlib.zsh
done
unset zlib zlibs

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
