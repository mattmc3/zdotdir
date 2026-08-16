_zrcs=($ZDOTDIR/conf.d/*.{z,}sh(N-.))
for _zrc in ${(o)_zrcs}; do
  [[ "${_zrc:t}" == '~'* ]] || source "$_zrc"
done
unset _zrc{,s}
