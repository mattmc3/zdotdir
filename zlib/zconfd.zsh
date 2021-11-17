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
