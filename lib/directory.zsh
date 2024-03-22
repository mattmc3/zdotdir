#
# directory: Set options and aliases related to Zsh directories and dirstack.
#

# 16.2.1 Changing Directories
setopt auto_pushd         # Make cd push the old directory onto the dirstack.
setopt pushd_minus        # Exchanges meanings of +/- when navigating the dirstack.
setopt pushd_silent       # Do not print the directory stack after pushd or popd.
setopt pushd_to_home      # Push to home directory when no argument is given.

# 16.2.3 Expansion and Globbing
setopt extended_glob      # Use more awesome globbing features.
setopt glob_dots          # Include dotfiles when globbing.

# 16.2.6 Input/Output
setopt path_dirs          # Perform path search even on command names with slashes.
setopt NO_clobber         # Don't overwrite files with >. Use >| to bypass.
setopt NO_rm_star_silent  # Ask for confirmation for `rm *' or `rm path/*'

# 16.2.9 Scripts and Functions
setopt multios        # Write to multiple descriptors.

# Set directory aliases.
alias dirh='dirs -v'
alias -- -='cd -'

() {
  local index dotdots=".."
  for index in {1..9}; do
    alias "$index"="cd -${index}"   # dirstack aliases (eg: "3"="cd -3")
    alias -g "..$index"="$dotdots"  # backref aliases (eg: "..3"="../../..")
    dotdots+='/..'
  done
}
