#region HEADER
#
# conf.d: Use a Fish-like conf.d directory for sourcing configs.
#

0=${(%):-%N}
zstyle -t ':zephyr:lib:bootstrap' loaded || source ${0:a:h:h:h}/lib/bootstrap.zsh
#endregion

# Return if requirements are not met.
! zstyle -t ":zephyr:plugin:confd" skip || return 0

function run_confd {
  # Find the conf.d directory.
  local confd user_confd
  zstyle -a ':zephyr:plugin:confd' directory 'user_confd'
  local -a confd_choices=(
    ${~user_confd}
    $__zsh_config_dir/conf.d(N)
    $__zsh_config_dir/zshrc.d(N)
    $__zsh_config_dir/rc.d(N)
    ${ZDOTDIR:-$HOME}/.zshrc.d(N)
  )
  confd=$confd_choices[1]
  #echo "THE CONFD DIR IS: $confd"
  if [[ ! -e "$confd" ]]; then
    echo >&2 "confd: dir not found '${confd:-$__zsh_config_dir/conf.d}'."
    return 1
  fi

  # Sort and source all scripts in conf.d.
  local rc; local -a rcs=(${confd}/*.{z,}sh(N))
  for rc in ${(o)rcs}; do
    # ignore files that begin with ~
    [[ "${rc:t}" != '~'* ]] || continue
    source "$rc"
  done

  # We can run this early, so if we did we no longer need a post_zshrc hook.
  post_zshrc_hook=(${post_zshrc_hook:#run_confd})
}

# Allow the user to bypass the confd deferral and run it immediately. Otherwise, we
# hook run_confd to the custom post_zshrc event.
if zstyle -t ':zephyr:plugin:confd' immediate; then
  run_confd || return 1
else
  post_zshrc_hook+=(run_confd)
fi

#region MARK LOADED
zstyle ':zephyr:plugin:confd' loaded 'yes'
#endregion
