#
# macos - Helpful functions for Mac users
#

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
# https://github.com/sorin-ionescu/prezto/tree/master/modules/osx

[[ "$OSTYPE" == darwin* ]] || return

fpath+=(${0:A:h}/functions)
autoload -U $fpath[-1]/*(.:t)

# canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# macOS has no 'md5sum', so use 'md5' as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no 'sha1sum', so use 'shasum' as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"
