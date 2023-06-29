#
# Init
#

0=${(%):-%N}
fpath+="${0:A:h}/functions"
autoload -Uz promptinit && promptinit
