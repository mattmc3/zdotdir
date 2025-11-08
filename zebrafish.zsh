#
# zebrafish - Still Zsh, but more like Fish.
#

#
# Init Zebrafish
#

typeset -g ZEBRAFISH_VERSION="5.0.0"
export ZSH_CONFIG_DIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
export ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p $ZSH_CONFIG_DIR $ZSH_DATA_DIR $ZSH_CACHE_DIR

#
# Libraries
#

for _lib in $ZSH_CONFIG_DIR/lib/*.zsh(N); do
  [[ "${_lib:t}" != "zebrafish.zsh" ]] || continue
  source $_lib
done
unset _lib

#
# General
#

# Set Zsh options.
setopt extended_glob           # Use extended globbing syntax.
setopt glob_dots               # Don't hide dotfiles from glob patterns.
setopt combining_chars         # Combine 0-len chars with base chars (eg: accents).
setopt interactive_comments    # Enable comments in interactive shell.
setopt rc_quotes               # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
setopt NO_beep                 # Be quiet.
setopt NO_mail_warning         # Don't print a warning if a mail file was accessed.

# Ensure uniqueness in our builtin arrays.
typeset -gaU cdpath fpath mailpath path prepath

#
# Environment
#

# Set the list of directories that Zsh searches for programs.
[[ -n "$prepath" ]] || prepath=(
  $HOME/{,s}bin(N)
  $HOME/.local/{,s}bin(N)
)

path=(
  $prepath
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

export BROWSER="${BROWSER:-open}"
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"
export PAGER="${PAGER:-less}"
export LANG="${LANG:-en_US.UTF-8}"

#
# Colorize
#

# Built-in Zsh colors
autoload -Uz colors && colors

# BSD colors.
export LSCOLORS="${LSCOLORS:-exfxcxdxbxGxDxabagacad}"
export LS_COLORS="${LS_COLORS:-di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43}"

# Colorize commands
alias ls="${aliases[ls]:-ls} --color=auto"
alias grep="${aliases[grep]:-grep} --color=auto"

# Colorize man pages.
export LESS_TERMCAP_mb=$'\e[01;34m'      # mb:=start blink-mode (bold,blue)
export LESS_TERMCAP_md=$'\e[01;34m'      # md:=start bold-mode (bold,blue)
export LESS_TERMCAP_so=$'\e[00;47;30m'   # so:=start standout-mode (white bg, black fg)
export LESS_TERMCAP_us=$'\e[04;35m'      # us:=start underline-mode (underline magenta)
export LESS_TERMCAP_se=$'\e[0m'          # se:=end standout-mode
export LESS_TERMCAP_ue=$'\e[0m'          # ue:=end underline-mode
export LESS_TERMCAP_me=$'\e[0m'          # me:=end modes

#
# File system
#

setopt auto_pushd              # Make cd push the old directory onto the dirstack.
setopt pushd_ignore_dups       # Don’t push multiple copies of the same directory onto the dirstack.
setopt pushd_minus             # Exchanges meanings of +/- when navigating the dirstack.
setopt pushd_silent            # Do not print the directory stack after pushd or popd.
setopt pushd_to_home           # Push to home directory when no argument is given.
setopt multios                 # Write to multiple descriptors.
setopt NO_clobber              # Don't overwrite files with >. Use >| to bypass.
setopt NO_rm_star_silent       # Ask for confirmation for `rm *' or `rm path/*'

alias dirh='dirs -v'

#
# History
#

setopt bang_hist               # Treat the '!' character specially during expansion.
setopt extended_history        # Write the history file in the ':start:elapsed;command' format.
setopt hist_expire_dups_first  # Expire a duplicate event first when trimming history.
setopt hist_find_no_dups       # Do not display a previously found event.
setopt hist_ignore_all_dups    # Delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_dups        # Do not record an event that was just recorded again.
setopt hist_ignore_space       # Do not record an event starting with a space.
setopt hist_reduce_blanks      # Remove extra blanks from commands added to the history list.
setopt hist_save_no_dups       # Do not write a duplicate event to the history file.
setopt hist_verify             # Do not execute immediately upon history expansion.
setopt inc_append_history      # Write to the history file immediately, not when the shell exits.
setopt NO_hist_beep            # Don't beep when accessing non-existent history.
setopt NO_share_history        # Don't share history between all sessions.

HISTFILE=$ZSH_DATA_DIR/zsh_history  # The path to the history file.
HISTSIZE=20000   # The maximum number of events to save in the internal history.
SAVEHIST=100000  # The maximum number of events to save in the history file.

#
# Job control
#

setopt auto_resume     # Attempt to resume existing job before creating a new process.
setopt long_list_jobs  # List jobs in the long format by default.
setopt notify          # Report status of background jobs immediately.
setopt NO_bg_nice      # Don't run all background jobs at a lower priority.
setopt NO_check_jobs   # Don't report on jobs when shell exit.
setopt NO_hup          # Don't kill jobs on shell exit.

#
# Editor
#

# Allow mapping Ctrl+S and Ctrl+Q shortcuts
[[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]] && stty -ixon <$TTY >$TTY

# Treat these characters as part of a word.
zstyle -s ':zebrafish:editor' wordchars 'WORDCHARS' \
  || WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

function update-cursor-style {
  local style seq

  # We currently only support the xterm family of terminals
  if [[ "${TERM}-" != (xterm|rxvt|tmux)-* ]]; then
    return
  fi

  # Try to get style for the current keymap, fallback to sensible defaults
  zstyle -s ":zebrafish:editor:$KEYMAP" cursor style
  if [[ -z "$style" ]]; then
    case "$KEYMAP" in
      main|emacs|viins) style=line ;;
      *)                style=block ;;
    esac
  fi

  # Map style to DECSCUSR and print (with tmux passthrough if needed)
  case ${style:l} in
    block)                 seq=$'\e[2 q' ;;
    underline|underscore)  seq=$'\e[4 q' ;;
    bar|beam|line)         seq=$'\e[6 q' ;;
    *)                     return ;;
  esac
  if [[ -n $TMUX ]]; then
    printf '\ePtmux;\e%s\e\\' "${seq#\e}"
  else
    printf '%s' "$seq"
  fi
}
zle -N update-cursor-style

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
zmodload -i zsh/terminfo
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
    zle update-cursor-style
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use emacs key bindings
bindkey -e

# Meta-Arrow keys - move by word
bindkey -M emacs '^[[1;3C' forward-word
bindkey -M emacs '^[[1;3D' backward-word

# Start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey -M emacs "^[[A" up-line-or-beginning-search
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M emacs "^[[B" down-line-or-beginning-search
if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
fi

# [M-Backspace] delete the previous word
bindkey -M emacs '^[^?' backward-kill-word
bindkey -M emacs '^[\b' backward-kill-word

# [Space] - perform history expansion (magic-space)
bindkey ' ' magic-space

# Edit the current command line in $VISUAL (or $EDITOR / `vi` if not set)
autoload -U edit-command-line
zle -N edit-command-line
function edit-command-line-editor() {
  # Prefer $EDITOR over $VISUAL for this widget
  local VISUAL=${EDITOR:-vim}
  zle edit-command-line
}
zle -N edit-command-line-editor
bindkey '\C-x\C-e' edit-command-line-editor

#
# Utilities
#

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Load more specific 'run-help' function from $fpath.
(( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
alias help=run-help

#
# Functions
#

# Add Fish-like lazy-load functions directory.
for _fndir in $ZSH_CONFIG_DIR/functions(/FN) $ZSH_CONFIG_DIR/functions/*(/FN); do
  fpath=($_fndir $fpath)
  autoload -Uz $_fndir/*~*/_*(N.:t)
done
unset _fndir

#
# Completions
#

setopt always_to_end     # Move cursor to the end of a completed word.
setopt auto_list         # Automatically list choices on ambiguous completion.
setopt auto_menu         # Show completion menu on a successive tab press.
setopt auto_param_slash  # If completed parameter is a directory, add a trailing slash.
setopt complete_in_word  # Complete from both ends of a word.
setopt path_dirs         # Perform path search even on command names with slashes.
setopt NO_flow_control   # Disable start/stop characters in shell editor.
setopt NO_menu_complete  # Do not autoselect the first completion entry.

# Add Fish-like custom completions directory.
fpath=($ZSH_CONFIG_DIR/completions(/FN) $fpath)

# Set ZSH_COMPDUMP path
zstyle -s ':zebrafish:completions' path 'ZSH_COMPDUMP' \
  || ZSH_COMPDUMP=$ZSH_CACHE_DIR/zcompdump

# Basic completion zstyles
zmodload -i zsh/complist
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

#
# Prompt
#

setopt prompt_subst  # Expand parameters in prompt variables

# Set 2 space indent for each new level in a multi-line script. This can then be
# overridden by a prompt or plugin, but is a better default than Zsh's.
PS2='${${${(%):-%_}//[^ ]}// /  }    '

# Initialize prompt system.
autoload -Uz promptinit && promptinit

#
# Plugins
#

# Clone-only plugins
zstyle -a ':zebrafish:clone' plugins 'clone_plugins' \
|| clone_plugins=()

# External plugins
zstyle -a ':zebrafish:load' plugins 'plugins' \
|| plugins=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting
)

function clone_zsh_plugins() {
  emulate -L zsh
  setopt local_options no_monitor
  local zf_plugin
  for zf_plugin in $@; do
    [[ -d $ZSH_CONFIG_DIR/plugins/${zf_plugin:t} ]] && continue
    git clone --quiet --depth 1 https://github.com/$zf_plugin $ZSH_CONFIG_DIR/plugins/${zf_plugin:t} &
  done
  wait
}
clone_zsh_plugins ${${(M)plugins:#*/*}:#/*} ${clone_plugins[@]}

# Add plugins to fpath
for _plugin in $plugins; do
  fpath+=("$ZSH_CONFIG_DIR/plugins/${_plugin:t}"(N))
done

# Initialize compinit system.
autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"

# Load Zsh plugins
for _plugin in $plugins; do
  if [[ ! -d "$ZSH_CONFIG_DIR/plugins/${_plugin:t}" ]]; then
    print -ru2 "Plugin not found: '$_plugin'."
    continue
  fi
  source "$ZSH_CONFIG_DIR/plugins/${_plugin:t}/${_plugin:t}.plugin.zsh"
done
unset _plugin

#
# conf.d
#

zstyle -s ':zebrafish:confd' path '_confd' || _confd=$ZSH_CONFIG_DIR/conf.d
for _zfile in ${_confd}/*.zsh(N); do
  [[ $_zfile:t != '~'* ]] || continue
  source $_zfile
done
unset _zfile _confd
