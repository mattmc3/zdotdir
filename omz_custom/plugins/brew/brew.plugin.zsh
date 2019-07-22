export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CASK_OPTS="${HOMEBREW_CASK_OPTS:---appdir=/Applications}"
alias bcu="brew cu"

brew_export() {
  # brew is a pain... it dumps to a forced Brewfile, and is not consistently
  # sorted, making version controling your Brewfile tricky. #FixedIt
  local brewfile="/tmp/Brewfile.tmp"
  brew bundle dump --force --file="$brewfile"
  grep '^tap\ '  "$brewfile" | sort  > "$brewfile".2
  grep '^brew\ ' "$brewfile" | sort >> "$brewfile".2
  grep '^cask\ ' "$brewfile" | sort >> "$brewfile".2
  grep '^mas\ '  "$brewfile" | sort >> "$brewfile".2
  cat "$brewfile".2
  command rm "$brewfile" "$brewfile".2
}

brew_import() {
  [[ -f "$1" ]] || { echo "Usage: Expecting valid Brewfile path" >&2; return; }
  brew bundle --file="$1"
}
