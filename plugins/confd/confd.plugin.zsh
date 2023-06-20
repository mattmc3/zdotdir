#
# confd - Source all zsh files from a Fish-like conf.d directory
#

for _zfile in ${ZDOTDIR:-$HOME/.config/zsh}/conf.d/*.zsh(N); do
  # ignore files that begin with ~
  [[ _zfile:t == '~'* ]] && continue
  source "$_zfile"
done
unset _zfile
