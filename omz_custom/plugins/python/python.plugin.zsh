# python
export WORKON_HOME="${WORKON_HOME:-$HOME/.virtualenvs}"

alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

workon() {
  [[ -z "$1" ]] && { echo "Expecting workon project name"; return 1; }
  source "$WORKON_HOME/$1/bin/activate"
}

pyclean() {
  find . -type f -name "*.py[co]" -delete
  find . -type d -name "__pycache__" -delete
}

if [[ -n $WORKON_HOME ]]; then
  # python: tab complete for workon dir (virtualenv)
  compdef '_files -W "$WORKON_HOME"' workon &> /dev/null
fi

pip_export() {
  __pip_export "pip" "$@"
}

pip2_export() {
  __pip_export "pip2" "$@"
}

pip3_export() {
  __pip_export "pip3" "$@"
}

__pip_export() {
  $1 freeze
}

pip_import() {
  __pip_import "pip" "$@"
}

pip2_import() {
  __pip_import "pip2" "$@"
}

pip3_import() {
  __pip_import "pip3" "$@"
}

__pip_import() {
  [[ -f "$2" ]] || { echo "Usage: Expecting valid requirements.txt path" >&2; return; }
  $1 install -r "$2"
}
