# brew: Environment variables and functions for homebrew users.

# References:
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
# - https://github.com/sorin-ionescu/prezto/tree/master/modules/homebrew

# Where is brew?
# Setup homebrew if it exists on the system.
typeset -aU _brewcmd=(
  $commands[brew]
  $HOME/.homebrew/bin/brew(N)
  $HOME/.linuxbrew/bin/brew(N)
  /opt/homebrew/bin/brew(N)
  /usr/local/bin/brew(N)
  # /home/linuxbrew/.linuxbrew/bin/brew(N)
)
(( ${#_brewcmd} )) || return 1

# Ensure path arrays contain no duplicates.
typeset -gU cdpath fpath path

# brew shellenv
source <($_brewcmd[1] shellenv)

# Ensure user bins preceed homebrew in path.
prepath=(
    $HOME/{,s}bin(N)
    $HOME/.local/{,s}bin(N)
)
path=($prepath $path)

# Default to no tracking.
HOMEBREW_NO_ANALYTICS="${HOMEBREW_NO_ANALYTICS:-1}"

# Add brewed Zsh to fpath
if [[ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
fi

# Add keg-only completions to fpath
zstyle -a ':zsh_custom:plugin:brew' 'keg-only-brews' '_kegonly' \
  || _kegonly=(curl ruby sqlite)
for _keg in $_kegonly; do
  fpath=($HOMEBREW_PREFIX/opt/${_keg}/share/zsh/site-functions(/N) $fpath)
done
unset _keg{,only}

# Set aliases.
alias brewup="brew update && brew upgrade && brew cleanup"
alias brewinfo="brew leaves | xargs brew desc --eval-all"

brewdeps() {
  emulate -L zsh; setopt local_options
  local bluify_deps='
    BEGIN { blue = "\033[34m"; reset = "\033[0m" }
          { leaf = $1; $1 = ""; printf "%s%s%s%s\n", leaf, blue, $0, reset}
  '
  brew leaves | xargs brew deps --installed --for-each | awk "$bluify_deps"
}

# Handle brew on multi-user Apple silicon.
if [[ "$HOMEBREW_PREFIX" == /opt/homebrew ]]; then
  _brew_owner="$(stat -f "%Su" "$HOMEBREW_PREFIX" 2>/dev/null)"
  if [[ -n "$_brew_owner" ]] && [[ "$(whoami)" != "$_brew_owner" ]]; then
    alias brew="sudo -Hu '$_brew_owner' brew"
  fi
  unset _brew_owner
fi
