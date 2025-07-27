#region HEADER
#
# macos: Aliases and functions for macOS users.
#

# References
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
# - https://github.com/sorin-ionescu/prezto/tree/master/modules/osx
#endregion

# Return if requirements are not met.
[[ "$OSTYPE" == darwin* ]] || return 1
! zstyle -t ":zephyr:plugin:macos" skip || return 0

# Load plugin functions.
0=${(%):-%N}
fpath=(${0:a:h}/functions $fpath)
autoload -Uz ${0:a:h}/functions/*(.:t)

#region MARK LOADED
zstyle ':zephyr:plugin:macos' loaded 'yes'
#endregion
