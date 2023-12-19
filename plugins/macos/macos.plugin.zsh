#
# macos - Aliases and functions for macOS users.
#

#
# References
#

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
# https://github.com/sorin-ionescu/prezto/tree/master/modules/osx

#
# Requirements
#

[[ "$OSTYPE" == darwin* ]] || return 1

#
# Init
#

fpath=(${0:a:h}/functions $fpath)
autoload -U ${0:a:h}/functions/*(.:t)

# canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# macOS has no 'md5sum', so use 'md5' as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no 'sha1sum', so use 'shasum' as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"
