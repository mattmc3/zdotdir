#
# directory - set directory options and aliases
#

#
# Options
#

setopt auto_cd                 # Auto changes to a directory without typing cd.
setopt auto_pushd              # Make cd push the old directory onto the dirstack.
setopt cdable_vars             # Change directory to a path stored in a variable.
setopt extended_glob           # Use extended globbing syntax.
setopt glob_dots               # Don't hide dotfiles from glob patterns.
setopt multios                 # Write to multiple descriptors.
setopt pushd_ignore_dups       # Don’t push multiple copies of the same directory onto the dirstack.
setopt pushd_minus             # Exchanges meanings of +/- when navigating the dirstack.
setopt pushd_silent            # Do not print the directory stack after pushd or popd.
setopt pushd_to_home           # Push to home directory when no argument is given.
setopt NO_clobber              # Don't overwrite files with >. Use >| to bypass.
setopt NO_rm_star_silent       # Ask for confirmation for `rm *' or `rm path/*'

#
# Aliases
#

alias -- -='cd -'
alias dirh='dirs -v'
for index in {1..9}; do
  alias "$index"="cd +${index}"
  alias -g "..$index"=$(printf '../%.0s' {1..$index})
done
unset index
