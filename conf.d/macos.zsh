# macos ------------------------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  alias lmk="say 'Process complete.'"
  alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

  alias brewup="brew update && brew upgrade"
  alias caskup="brew cu -af"
  alias bcu="brew cu"
  alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to clipboard.'"

  # Recursively clean files
  alias cleands="find . -name '.DS_Store' -depth -exec rm {} \;"

  # Canonical hex dump; some systems have this symlinked
  command -v hd > /dev/null || alias hd="hexdump -C"

  # macOS has no 'md5sum', so use 'md5' as a fallback
  command -v md5sum > /dev/null || alias md5sum="md5"

  # macOS has no 'sha1sum', so use 'shasum' as a fallback
  command -v sha1sum > /dev/null || alias sha1sum="shasum"

  # images {{{
  # auto-orient images based on exif tags
  alias autorotate="jhead -autorot"

  # mogrify -resize 20% image.jpg  # make image 20% of its original size
  # }}}
fi
