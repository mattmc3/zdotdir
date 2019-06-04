# python -----------------------------------------------------------------------
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

if [[ -n $ZSH_VERSION ]]; then
  # python: tab complete for workon dir (virtualenv)
  compdef '_files -W "$WORKON_HOME"' workon &> /dev/null
fi
