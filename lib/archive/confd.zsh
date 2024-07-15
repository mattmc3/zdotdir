#
# conf.d: Use a Fish-like conf.d directory for sourcing configs.
#

# Find the conf.d directory.
: __zsh_config_dir=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}
zstyle -a ':zephyr:plugin:confd' directory '_user_confd'
typeset -a _confd=(
  ${~_user_confd}
  $__zsh_config_dir/conf.d(N)
  $__zsh_config_dir/zshrc.d(N)
  $__zsh_config_dir/rc.d(N)
  ${ZDOTDIR:-$HOME}/.zshrc.d(N)
)
if [[ ! -e "$_confd[1]" ]]; then
  echo >&2 "confd: dir not found '$_confd[1]'."
  return 1
fi

# Sort and source conf files.
typeset -ga _rcs=(${_confd[1]}/*.{z,}sh(N))
for _rc in ${(o)_rcs}; do
  # ignore files that begin with ~
  [[ ${_rc:t} != '~'* ]] || continue
  source $_rc
done

# Clean up.
unset _rc{,s} {,_user}_confd
