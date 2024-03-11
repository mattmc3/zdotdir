#
# env: Ensure common environment variables are set.
#

# Set common variables if they have not already been set.
export EDITOR=${EDITOR:-vim}
export VISUAL=${VISUAL:-vim}
export PAGER=${PAGER:-less}
export LANG=${LANG:-en_US.UTF-8}

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
export LESS="${LESS:--g -i -M -R -S -w -z-4}"

# macOS
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER=${BROWSER:-open}

  # Make Apple Terminal behave.
  export SHELL_SESSIONS_DISABLE=${SHELL_SESSIONS_DISABLE:-1}
fi

# Misc
export KEYTIMEOUT=${KEYTIMEOUT:-1}

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER
