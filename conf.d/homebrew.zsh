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

# Add brewed Zsh to fpath
if [[ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
fi

# Add keg-only completions to fpath
local keg kegonly
zstyle -a ':zsh:homebrew' 'keg-only-brews' 'kegonly' \
  || kegonly=(curl ruby sqlite)
for keg in $kegonly; do
  fpath=($HOMEBREW_PREFIX/opt/${keg}/share/zsh/site-functions(/N) $fpath)
done

# Handle brew on multi-user Apple silicon.
local brew_owner
if [[ "$OSTYPE" == darwin* ]] && [[ "$HOMEBREW_PREFIX" == /opt/homebrew ]]; then
  brew_owner="$(stat -f "%Su" "$HOMEBREW_PREFIX" 2>/dev/null)"
  if [[ -n "$brew_owner" ]] && [[ "$(whoami)" != "$brew_owner" ]]; then
    alias brew="sudo -Hu '$brew_owner' brew"
  fi
fi
