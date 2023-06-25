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

zstyle -s ':zephyr:plugin:otp' home 'OTP_HOME' ||
  OTP_HOME="${OTP_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/otp}"
[[ -d $OTP_HOME ]] || mkdir -p $OTP_HOME

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
  reply=($(find $OTP_HOME -name \*.otp.asc | xargs basename -s .otp.asc))
}

compctl -K __otp_keys otp

#
# Wrap up
#

zstyle ":zephyr:plugin:otp" loaded 'yes'
