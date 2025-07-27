#region HEADER
#
# directory: Set features related to Zsh directories and dirstack.
#
#endregion

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1
! zstyle -t ":zephyr:plugin:directory" skip || return 0

# Set Zsh options related to directories, globbing, and I/O.
setopt auto_pushd         # Make cd push the old directory onto the dirstack.
setopt pushd_minus        # Exchanges meanings of +/- when navigating the dirstack.
setopt pushd_silent       # Do not print the directory stack after pushd or popd.
setopt pushd_to_home      # Push to home directory when no argument is given.
setopt multios            # Write to multiple descriptors.
setopt extended_glob      # Use extended globbing syntax (#,~,^).
setopt glob_dots          # Don't hide dotfiles from glob patterns.
setopt NO_clobber         # Don't overwrite files with >. Use >| to bypass.
setopt NO_rm_star_silent  # Ask for confirmation for `rm *' or `rm path/*'

# Set directory aliases.
if ! zstyle -t ':zephyr:plugin:directory:alias' skip; then
  alias -- -='cd -'
  alias dirh='dirs -v'

  _dotdot=".."
  for _index in {1..9}; do
    alias "$_index"="cd -${_index}"      # dirstack aliases (eg: "2"="cd -2")
    alias -g "..${_index}"="${_dotdot}"  # backref aliases (eg: "..3"="../../..")
    _dotdot+="/.."
  done
  unset _dotdot _index
fi

# Quickly go up any number of directories.
function up {
  local parents="${1:-1}"
  if [[ ! "$parents" -gt 0 ]]; then
    echo >&2 "usage: up [<num>]"
    return 1
  fi
  local dotdots=".."
  while (( --parents )); do
    dotdots+="/.."
  done
  cd "$dotdots"
}

#region MARK LOADED
zstyle ':zephyr:plugin:directory' loaded 'yes'
#endregion
