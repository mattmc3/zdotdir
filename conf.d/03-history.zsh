# history ------------------------------------------------------------------ {{{
# history: http://zsh.sourceforge.net/Doc/Release/Options.html#History

# omz lib/history.zsh

# history wrapper
function omz_history {
  local clear list
  zparseopts -E c=clear l=list

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    echo >&2 History file deleted. Reload the session to see its effects.
  elif [[ -n "$list" ]]; then
    # if -l provided, run as if calling `fc' directly
    builtin fc "$@"
  else
    # unless a number is provided, show all history events (starting from 1)
    [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
  fi
}

# timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  "") alias history='omz_history' ;;
  *) alias history="omz_history -t '$HIST_STAMPS'" ;;
esac

# history command configuration
setopt EXTENDED_HISTORY          # write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # do not display a previously found event.
setopt HIST_IGNORE_SPACE         # do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # do not write a duplicate event to the history file.
setopt HIST_VERIFY               # do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # don't store history commands
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks from each command line being added to the history list.
setopt NO_HIST_BEEP              # don't beep when attempting to access a missing history entry

# history file configuration
SAVEHIST="${SAVEHIST:-100000}"
HISTSIZE="${HISTSIZE:-50000}"

if [[ -z $HISTFILE ]]; then
  if [[ -d $XDG_DATA_HOME ]]; then
    HISTFILE="$XDG_DATA_HOME/zsh/history"
    [[ -d "$XDG_DATA_HOME"/zsh ]] || mkdir -p "$XDG_DATA_HOME"/zsh
  else
    HISTFILE="$HOME/.zsh_history"
  fi
fi

# omz plugins/history/history.plugin.zsh
alias h='history'
function hs {
  history | grep -i $*
}
