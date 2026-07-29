#
# python - Aliases and functions for python
#

# workon
export WORKON_HOME="${WORKON_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/venvs}"

# python aliases
alias py3='python3'
alias py='python'
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pipup="pip list --outdated | cut -d ' ' -f1 | xargs -n1 pip install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

function pipup {
  pip list --outdated | cut -d ' ' -f1 | xargs -n1 pip install -U
}

function pyclean {
  # Clean common python cache files.
  find "${@:-.}" -type f -name "*.py[co]" -delete
  find "${@:-.}" -type d -name "__pycache__" -delete
  find "${@:-.}" -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
  find "${@:-.}" -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}

function venv {
  # venv - Manage Python venvs.
  local workon_home
  local -a usage o_list o_remove o_path
  workon_home=${WORKON_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/venvs}

  usage=(
    "usage: venv [--home=<home>] [-r|--remove] [-p|--path] <pyvenv>"
    "       venv [-h|--help] [-l|--list]"
  )

  # Parse arguments
  while (( $# )); do
    case $1 in
      --)
        shift
        break
        ;;
      -h|--help)
        printf "%s\n" $usage
        return
        ;;
      -l|--list)
        o_list+=($1)
        ;;
      -r|--remove)
        o_remove+=($1)
        ;;
      -p|--path)
        o_path+=($1)
        ;;
      --home)
        shift
        workon_home=$1
        ;;
      --home=*)
        workon_home=("${1#*=}")
        ;;
      -*)
        echo >&2 "workon: Unknown option '$1'."
        return 2
        ;;
      *)
        break
        ;;
    esac
    shift
  done

  [[ -d "$workon_home" ]] || mkdir -p "$workon_home"

  # --list
  if (( $#o_list )); then
    local venv
    for venv in $workon_home/*(-/FN); do
      echo ${venv:t}
    done
    return
  fi

  # Expecting <pyvenv>
  if (( $# == 0 )); then
    echo >&2 "usage: venv <pyvenv>"
    return 1
  fi

  # --path
  if (( $#o_path )); then
    if [[ ! -d "$workon_home/$1" ]]; then
      echo >&2 "venv: venv not found '$1'."
      return 1
    fi
    echo "$workon_home/$1"
    return
  fi

  # --remove
  if (( $#o_remove )); then
    if [[ ! -d "$workon_home/$1" ]]; then
      echo >&2 "venv: venv not found '$1'."
      return 1
    fi
    rm -rf -- "$workon_home/$1"
    return
  fi

  # Make venv if missing and activate
  if [[ ! -d "$workon_home/$1" ]]; then
    python3 -m venv "$workon_home/$1" || return 1
  fi
  source "$workon_home/$1/bin/activate"
}

function workon {
  venv -- "$@"
}

# Mark the plugin as loaded
zstyle ':zsh_custom:plugin:python' loaded 'yes'
