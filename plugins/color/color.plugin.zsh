local zsh_cache=${XDG_CACHE_HOME:=$HOME/.cache}/zsh
[[ -d $zsh_cache ]] || mkdir -p $zsh_cache

#
# Aliases
#

local prefix cache

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

if [[ "$OSTYPE" == darwin* ]]; then
  alias ls="${aliases[ls]:-ls} -G"
fi

alias grep="${aliases[grep]:-grep} --color=auto"

#
# Variables
#

export LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}
export LSCOLORS=${LSCOLORS:-exfxcxdxbxGxDxabagacad}

# Man page color
# 0-black, 1-red, 2-green, 3-yellow, 4-blue, 5-magenta, 6-cyan, 7-white
export LESS_TERMCAP_mb=$'\E[01;36m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;36m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[04;35m'      # Begins underline.

if [[ "$OSTYPE" == darwin* ]]; then
  CLICOLOR=1
fi
