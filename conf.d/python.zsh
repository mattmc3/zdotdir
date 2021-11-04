if [[ -z $WORKON_HOME ]]; then
  export WORKON_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/venvs
  [[ -d "$WORKON_HOME" ]] || mkdir -p "$WORKON_HOME"
fi

alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

function pyclean {
  find . -type f -name "*.py[co]" -delete
  find . -type d -name "__pycache__" -delete
}

function workon {
  if [[ -z "$1" ]]; then
    >&2 echo "Expecting workon project name" && return 1
  elif [[ -z "$WORKON_HOME" ]]; then
    >&2 echo "\$WORKON_HOME not set" && return 1
  elif [[ ! -d "$WORKON_HOME" ]]; then
    >&2 echo "\$WORKON_HOME directory not found: $WORKON_HOME" && return 1
  fi
  source "$WORKON_HOME/$1/bin/activate"
}

function mkvenv {
  if [[ -n $1 ]]; then
    >&2 echo "mkvenv: Usage - mkvenv <venv-name>" && return 1
  elif [[ -z $WORKON_HOME ]]; then
    >&2 echo "mkvenv: \$WORKON_HOME not set" && return 1
  fi
  python3 -m venv "${WORKON_HOME}\${1}"
  workon "${1}"
}

# python: tab complete for workon dir (virtualenv)
compdef '_files -W "$WORKON_HOME"' workon &> /dev/null
