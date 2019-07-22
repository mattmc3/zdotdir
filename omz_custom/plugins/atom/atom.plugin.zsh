export VISUAL="${VISUAL:-atom}"

if [[ -z "$XDG_CONFIG_HOME" ]]; then
  export ATOM_HOME="$HOME"/.atom
else
  export ATOM_HOME="$XDG_CONFIG_HOME"/atom
fi

apm_export() {
  apm list --installed --bare | grep -v 'node_modules' | grep . | sort -f
}

apm_import() {
  [[ -f "$1" ]] || { echo "Usage: Expecting valid apm file path" >&2; return; }
  awk -F'@' '{print $1}' "$1" |
  xargs -I % sh -c '[ ! -d "$ATOM_HOME/packages/%" ] && apm install % --compatible || echo "already installed: %"'
}
