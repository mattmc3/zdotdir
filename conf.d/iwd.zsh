#
# iwd: initial working directory
#

# Check requirements.
! zstyle -t ':zsh_custom:plugin:iwd' loaded || return 1

# Set the initial working directory so we can easily return to it.
: ${IWD:=$PWD}
alias iwd='cd $IWD'
