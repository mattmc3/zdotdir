(( $+commands[brew] )) || return 1

if [[ -z "$HOMEBREW_PREFIX" ]]; then
  source <(brew shellenv)
fi
brew_owner=$(stat -f "%Su" $HOMEBREW_PREFIX)
if [[ $(whoami) != $brew_owner ]]; then
  alias brew="sudo -Hu '$brew_owner' brew"
fi
unset brew_owner
