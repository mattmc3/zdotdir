# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof

# like fish, we're going to use functions, conf.d, and completions directories
# to drive Zsh functionality

# functions
ZFUNCDIR="$ZDOTDIR/functions"
for _fndir in $ZFUNCDIR $ZFUNCDIR/**(/); do
  fpath+=$_fndir
  [[ ${ZPROFRC:-0} -eq 0 ]] || echo "$_fndir funcdir added to fpath"
done
for _fn in $ZFUNCDIR/**/*(.); do
  autoload -Uz "$_fn"
  [[ ${ZPROFRC:-0} -eq 0 ]] || echo "$_fn function file autoloaded"
done
unset _fndir _fn

# conf.d
ZCONFD="$ZDOTDIR/conf.d"
_conf_files=("$ZCONFD"/*.{sh,zsh}(.N))
# make sure the files are sorted properly
for _conf in ${(o)_conf_files}; do
  # ignore files that begin with a tilde
  case ${_conf:t} in '~'*) continue;; esac
  source "$_conf"
  [[ ${ZPROFRC:-0} -eq 0 ]] || echo "$_conf conf.d file sourced"
done
unset _files _conf_files

# completions
ZCOMPLETIONS="$ZDOTDIR/completions"
for _comp in $ZCOMPLETIONS/*.zsh(.N); do
  source "$_comp"
  [[ ${ZPROFRC:-0} -eq 0 ]] || echo "$_comp completion file sourced"
done
unset _comp

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
