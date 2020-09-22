if [[ -z $WORKON_HOME ]]; then
  export WORKON_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/venvs
  [[ -d "$WORKON_HOME" ]] || { mkdir -p "$WORKON_HOME" }
fi

alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

# python: tab complete for workon dir (virtualenv)
compdef '_files -W "$WORKON_HOME"' workon &> /dev/null
