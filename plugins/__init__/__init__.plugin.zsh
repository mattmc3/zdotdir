#region HEADER
#
# bootstrap: Ensure Zephyr is properly boostrapped.
#

# Set ZEPHYR_HOME.
0=${(%):-%N}
: ${ZEPHYR_HOME:=${0:a:h:h}}
#endregion

# Set critical Zsh options.
setopt extended_glob interactive_comments

# Set Zsh locations.
typeset -gx __zsh_{config,cache,user_data}_dir
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
mkdir -p $__zsh_config_dir $__zsh_user_data_dir $__zsh_cache_dir

# There's not really a post_zshrc event, so we're going to fake one by adding a
# function called run_post_zshrc to the precmd event. That function only runs once,
# and then unregisters itself. If the user wants to (or needs to because it doesn't
# play well with a plugin), they can run it themselves manually at the very end of
# their .zshrc, and then it unregisters the precmd event.

# Define a variable to hold actions run during the post_zshrc event.
typeset -ga post_zshrc_hook

# Add our new event.
function run_post_zshrc {
  # Run anything attached to the post_zshrc hook
  local fn
  for fn in $post_zshrc_hook; do
    # Uncomment to debug:
    # echo "post_zshrc is about to run: ${=fn}"
    "${=fn}"
  done

  # Now delete the precmd hook and self-remove this function and its list var so
  # that it only runs once, and doesn't keep running on every future precmd event.
  add-zsh-hook -d precmd run_post_zshrc
  unfunction -- run_post_zshrc
  unset -- post_zshrc_hook
}

# Attach run_post_zshrc to built-in precmd.
autoload -U add-zsh-hook
add-zsh-hook precmd run_post_zshrc

#region LOAD HELPERS
zstyle -t ':zephyr:plugin:helper' loaded \
  || source $ZEPHYR_HOME/plugins/helper/helper.plugin.zsh
#endregion

#region MARK LOADED
zstyle ":zephyr:lib:bootstrap" loaded 'yes'
#endregion
