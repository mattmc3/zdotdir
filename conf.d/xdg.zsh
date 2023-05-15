if [[ -n "$XDG_RUNTIME_DIR" ]] && [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
  for _xdgdir in XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_RUNTIME_DIR; do
    [[ -e ${(P)_xdgdir} ]] || mkdir -p ${(P)_xdgdir}
  done
  unset _xdgdir
fi
