#region HEADER
#
# environment: Ensure common environment variables are set.
#

# References:
# - https://github.com/sorin-ionescu/prezto/blob/master/modules/environment/init.zsh
# - https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zprofile

0=${(%):-%N}
zstyle -t ':zephyr:lib:bootstrap' loaded || source ${0:a:h:h:h}/lib/bootstrap.zsh
#endregion

# Return if requirements are not met.
! zstyle -t ":zephyr:plugin:environment" skip || return 0

# Set Zsh options related to globbing.
setopt extended_glob         # Use more awesome globbing features.
setopt NO_rm_star_silent     # Ask for confirmation for `rm *' or `rm path/*'

# Set general Zsh options.
setopt combining_chars       # Combine 0-len chars with the base character (eg: accents).
setopt interactive_comments  # Enable comments in interactive shell.
setopt rc_quotes             # Allow 'Hitchhikers''s Guide' instead of 'Hitchhikers'\''s Guide'.
setopt NO_mail_warning       # Don't print a warning message if a mail file has been accessed.
setopt NO_beep               # Don't beep on error in line editor.

# Set Zsh options related to job control.
setopt auto_resume           # Attempt to resume existing job before creating a new process.
setopt long_list_jobs        # List jobs in the long format by default.
setopt notify                # Report status of background jobs immediately.
setopt NO_bg_nice            # Don't run all background jobs at a lower priority.
setopt NO_check_jobs         # Don't report on jobs when shell exit.
setopt NO_hup                # Don't kill jobs on shell exit.

# Set XDG base dirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
if zstyle -T ':zephyr:plugin:environment' use-xdg-basedirs; then
  export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
  export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
  mkdir -p $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME $XDG_STATE_HOME
fi

# Editors
export EDITOR=${EDITOR:-nano}
export VISUAL=${VISUAL:-nano}
export PAGER=${PAGER:-less}

# Set browser.
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER=${BROWSER:-open}
fi

# Set language.
export LANG=${LANG:-en_US.UTF-8}

# Set the default Less options.
# Mouse-wheel scrolling can be disabled with -X (disable screen clearing).
# Add -X to disable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Reduce key delay
export KEYTIMEOUT=${KEYTIMEOUT:-1}

# Make Apple Terminal behave.
if [[ "$OSTYPE" == darwin* ]]; then
  export SHELL_SESSIONS_DISABLE=${SHELL_SESSIONS_DISABLE:-1}
fi

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Add /usr/local/bin to path.
path=(/usr/local/{,s}bin(N) $path)

# Set the list of directories that Zsh searches for programs.
if [[ ! -v prepath ]]; then
  typeset -ga prepath
  # If path ever gets out of order, you can use `path=($prepath $path)` to reset it.
  zstyle -a ':zephyr:plugin:environment' 'prepath' 'prepath' \
  || prepath=(
    $HOME/{,s}bin(N)
    $HOME/.local/{,s}bin(N)
  )
fi
path=(
  $prepath
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

#region MARK LOADED
zstyle ':zephyr:plugin:environment' loaded 'yes'
#endregion
