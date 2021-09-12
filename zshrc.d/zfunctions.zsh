# autoload functions
fndirs=(
  ${ZDOTDIR:-$HOME}/.zfunctions
  ${ZDOTDIR:-$HOME}/.zfunctions/*/(N)
  ${ZDOTDIR:-~/.config/zsh}/zfunctions
  ${ZDOTDIR:-~/.config/zsh}/zfunctions/*/(N)
  ${ZDOTDIR:-~/.config/zsh}/functions
  ${ZDOTDIR:-~/.config/zsh}/functions/*/(N)
)
for d in $fndirs; do
  [[ -d $d ]] || continue
  fpath=("$d" $fpath)
  for fn in "$d"/*(.N); do
    autoload -Uz "$fn"
  done
done
unset dirname fn fndirs
