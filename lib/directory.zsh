#
# Set Zsh directory options.
#

# Directory options
setopt AUTO_PUSHD            # cd automatically uses the dirstack.
setopt PUSHD_IGNORE_DUPS     # No duplicates in the dirstack.
setopt PUSHD_MINUS           # Swap meanings of +/- to be more natural.
setopt PUSHD_SILENT          # Do not print the dirstack after pushd/popd.
setopt PUSHD_TO_HOME         # pushd with no args goes to home.
setopt CDABLE_VARS           # Change directory to a path stored in a variable.
