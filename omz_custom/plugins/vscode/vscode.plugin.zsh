vscode_export() {
  code --list-extensions
}

vscode_import() {
  [[ -f "$1" ]] || { echo "Usage: Expecting valid extensions file path" >&2; return;  }
  cat "$1" | xargs -L 1 code --install-extension
}
