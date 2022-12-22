#
# Set my preferred Zsh options.
#

# https://zsh.sourceforge.io/Doc/Release/Options.html
_zopts=(
  # directory opts
  AUTO_PUSHD              # Push the old directory onto the stack when using cd.
  CDABLE_VARS             # Change directory to a path stored in a variable.
  PUSHD_MINUS             # Swap meanings of +/- in dirstack to be more natural.
  PUSHD_SILENT            # Do not print the dirstack after pushd/popd.
  PUSHD_TO_HOME           # pushd with no args goes to home.
  NO_PUSHD_IGNORE_DUPS    # Allow duplicates in the stack.


  # completion
  ALWAYS_TO_END           # Move cursor to the end of a completed word.
  AUTO_LIST               # Automatically list choices on ambiguous completion.
  AUTO_MENU               # Show completion menu on a successive tab press.
  AUTO_PARAM_SLASH        # If completed parameter is a directory, add a trailing slash.
  COMPLETE_IN_WORD        # Complete from both ends of a word.
  NO_MENU_COMPLETE        # Do not autoselect the first completion entry.

  # expansion and globbing opts
  EXTENDED_GLOB           # Use extended globbing syntax.
  GLOB_DOTS               # Include dotfiles when globbing.
  NO_CASE_GLOB            # Use case-insensitive glob completions.

  # hist opts
  BANG_HIST               # Treat the '!' character specially during expansion.
  EXTENDED_HISTORY        # Write the history file in the ':start:elapsed;command' format.
  HIST_EXPIRE_DUPS_FIRST  # Expire a duplicate event first when trimming history.
  HIST_FIND_NO_DUPS       # Do not display a previously found event.
  HIST_IGNORE_ALL_DUPS    # Delete an old recorded event if a new event is a duplicate.
  HIST_IGNORE_DUPS        # Do not record an event that was just recorded again.
  HIST_IGNORE_SPACE       # Do not record an event starting with a space.
  HIST_SAVE_NO_DUPS       # Do not write a duplicate event to the history file.
  HIST_VERIFY             # Do not execute immediately upon history expansion.
  INC_APPEND_HISTORY      # Write to the history file immediately, not when the shell exits.
  SHARE_HISTORY           # Share history between all sessions.
  NO_HIST_BEEP            # Do not beep when accessing non-existent history.
  NO_SHARE_HISTORY        # Don't share history between all sessions.

  # input/output opts
  INTERACTIVE_COMMENTS    # Enable comments in interactive shell.
  PATH_DIRS               # Perform path search even on command names with slashes.
  RC_QUOTES               # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
  NO_MAIL_WARNING         # Don't print a warning message if a mail file has been accessed.
  NO_RM_STAR_SILENT       # Ask for confirmation for `rm *' or `rm path/*'
  NO_FLOW_CONTROL         # Disable start/stop characters in shell editor.

  # jobs opts
  AUTO_RESUME            # Attempt to resume existing job before creating a new process.
  LONG_LIST_JOBS         # List jobs in the long format by default.
  NOTIFY                 # Report status of background jobs immediately.
  NO_BG_NICE             # Don't run all background jobs at a lower priority.
  NO_CHECK_JOBS          # Don't report on jobs when shell exit.
  NO_HUP                 # Don't kill jobs on shell exit.

  # prompt opts
  PROMPT_SUBST           # Expand parameters in prompt variables

  # scripts and functions
  MULTIOS                # Write to multiple descriptors.

  # zle opts
  COMBINING_CHARS        # Combine zero-length punctuation characters (accents) with the base character.
  NO_BEEP                # Be quiet!
)

setopt $_zopts
unset _zopts
