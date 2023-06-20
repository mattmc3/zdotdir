#
# color - Make terminal things more colorful.
#

#
# Requirements
#

[[ "$TERM" != 'dumb' ]] || return 1

#
# Functions
#

# Load plugin functions.
fpath=(${0:A:h}/functions $fpath)
autoload -U $fpath[1]/*(.:t)

#
# Variables
#

# Colorize man pages.
# start/end - md/me:bold; us/ue:underline; so/se:standout;
# colors    - 0-black; 1-red; 2-green; 3-yellow; 4-blue; 5-magenta; 6-cyan; 7-white;
export LESS_TERMCAP_mb=$'\e[01;36m'
export LESS_TERMCAP_md=$'\e[01;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[00;47;30m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[04;35m'

#
# Init
#

# Colorize ls and grep.
() {
  local prefix cache zsh_cache

  zsh_cache=${XDG_CACHE_HOME:=$HOME/.cache}/zsh
  [[ -d $zsh_cache ]] || mkdir -p $zsh_cache

  # Cache results of running dircolors for 20 hours, so it should almost
  # always regenerate the first time a shell is opened each day.
  for prefix in '' g; do
    if (( $+commands[${prefix}dircolors] )); then
      local dircolors_file=$zsh_cache/${prefix}dircolors.zsh
      local cache=($dircolors_file(Nmh-20))
      (( $#cache )) || ${prefix}dircolors --sh >| $dircolors_file

      source $dircolors_file
      alias ${prefix}ls="${aliases[${prefix}ls]:-${prefix}ls} --color=auto"
    fi
  done

  # if LS_COLORS was not set from dircolors, set it to a reasonable default.
  export LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}
  export LSCOLORS=${LSCOLORS:-exfxcxdxbxGxDxabagacad}

  if [[ "$OSTYPE" == darwin* ]]; then
    alias ls="${aliases[ls]:-ls} -G"
  fi

  alias grep="${aliases[grep]:-grep} --color=auto"
}
