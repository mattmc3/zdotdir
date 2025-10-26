#
# iwd: initial working directory
#

# Set the initial working directory so we can easily return to it.
: ${IWD:=$PWD}
alias iwd='cd $IWD'
