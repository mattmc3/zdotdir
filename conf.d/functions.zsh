#
# common-functions - Zsh functions
#

##? Show all extensions in current folder structure.
function allexts {
  find . -not \( -path '*/.git/*' -prune \) -type f -name '*.*' | sed 's|.*\.|\.|' | sort | uniq -c
}

##? Backup files or directories
function bak {
  local now f
  now=$(date +"%Y%m%d-%H%M%S")
  for f in "$@"; do
    if [[ ! -e "$f" ]]; then
      echo "file not found: $f" >&2
      continue
    fi
    cp -R "$f" "$f".$now.bak
  done
}

##? noext - Find files with no file extension
function noext {
  # for fun, rename with: noext -exec mv '{}' '{}.sql' \;
  find . -not \( -path '*/.git/*' -prune \) -type f ! -name '*.*'
}

##? optdiff - show a diff between set options and Zsh defaults
function optdiff {
  tmp1=$(mktemp)
  tmp2=$(mktemp)
  zsh -df -c "set -o" >| $tmp1
  set -o >| $tmp2
  gdiff --changed-group-format='%<' --unchanged-group-format='' $tmp2 $tmp1
  rm $tmp1 $tmp2
}

##? Remove zwc files
function rmzwc {
  if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    echo "rmzwc"
    echo "  removes zcompiled files"
    echo "options:"
    echo " -q         Quiet"
    echo " --dry-run  Dry run"
    echo " -h --help  Show help screen"
    return 0
  fi

  local findprint="-print"
  local finddel="-delete"
  if [[ "$1" == '-q' ]]; then
    findprint=""
  elif [[ "$1" == "--dry-run" ]]; then
    finddel=""
  fi

  if [[ -d "${ZDOTDIR}" ]]; then
    find "${ZDOTDIR:A}" -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
  fi
  find "$HOME" -maxdepth 1 -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
  find . -maxdepth 1 -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
}

##? Substitutes string parts with environment variables
function substenv {
  if (( $# == 0 )); then
    subenv ZDOTDIR | subenv HOME
  else
    local sedexp="s|${(P)1}|\$$1|g"
    shift
    sed "$sedexp" "$@"
  fi
}

##? Better tail -f
function tailf {
  local nl
  tail -f $2 | while read j; do
    print -n "$nl$j"
    nl="\n"
  done
}

##? Makes any dirs recursively and then touches a file if it doesn't exist
function touchf {
  if [[ -n "$1" ]] && [[ ! -f "$1" ]]; then
    mkdir -p "$1:h" && touch "$1"
  fi
}

##? What's the weather?
function weather {
  curl "http://wttr.in/$1"
}

##? Compile Zsh files in a directory
function zcompiledir {
  emulate -L zsh; setopt localoptions extendedglob globdots globstarshort nullglob rcquotes
  autoload -U zrecompile

  local f
  local flag_clean=false
  [[ "$1" == "-c" ]] && flag_clean=true && shift
  if [[ -z "$1" ]] || [[ ! -d "$1" ]]; then
    echo "Bad or missing directory $1" && return 1
  fi

  if [[ $flag_clean == true ]]; then
    for f in "$1"/**/*.zwc(.N) "$1"/**/*.zwc.old(.N); do
      echo "removing $f" && command rm -f "$f"
    done
  else
    for f in "$1"/**/*.zsh{,-theme}; do
      echo "compiling $f" && zrecompile -pq "$f"
    done
  fi
}

##? Echo to stderror
function echoerr {
  echo >&2 "$@"
}

##? Pass thru for copy/paste markdown
function $ { $@ }
