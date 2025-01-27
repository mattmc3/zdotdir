SECRETS_HOME="${SECRETS_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/secrets}"
if [[ ! -d "$SECRETS_HOME" ]]; then
  git clone git@github.com:mattmc3/secrets "$SECRETS_HOME"
fi
path=($prepath "$SECRETS_HOME/bin" $path)

function otp {
  otp.fish "$@"
}
