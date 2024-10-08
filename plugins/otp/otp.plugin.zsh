#
# otp - One-time passwords (multi-factor authentication from the command line)
#

#
# References
#

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/otp

#
# Variables
#

zstyle -s ':zdotdir:plugin:otp' home 'SECRETS_HOME' ||
  SECRETS_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/secrets"

[[ -d $SECRETS_HOME ]] ||
  git clone git@github.com:mattmc3/secrets $SECRETS_HOME

#
# Functions
#

# Load plugin functions.
0=${(%):-%N}
fpath=(${0:A:h}/functions $fpath)
autoload -Uz ${0:A:h}/functions/*(.:t)

#
# Completions
#

function __otp_keys {
  reply=($(find $SECRETS_HOME/otp -name \*.otp.asc | xargs basename -s .otp.asc))
}

compctl -K __otp_keys otp

#
# Wrap up
#

zstyle ":zdotdir:plugin:otp" loaded 'yes'
