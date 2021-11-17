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
