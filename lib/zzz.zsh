#
# zzz: Sleepily wait until the end, and then post-lib and post-zshrc.
#

# Source the antidote static plugins file.
source ${zsh_plugins}.zsh

# Set conf.d.
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${ZSHRCD:=$__zsh_config_dir/conf.d}

# Sort and source conf files.
_rcfiles=($ZSHRCD/*.{sh,zsh}(N))
for _rcfile in ${(o)_rcfiles}; do
  [[ ${_rcfile:t} == '~'* ]] && continue  # ignore tilde ~files
  source "$_rcfile"
done
unset _rcfile{,s}

# Init aliases.
[[ -r ${ZDOTDIR:-~}/.zaliases ]] && source ${ZDOTDIR:-~}/.zaliases

# Run this at the very end.
function zshrc-post {
  # Init prompt.
  (( $+functions[promptinit] )) || mypromptinit

  # Init completions.
  (( $+functions[compinit] )) || mycompinit

  # Finish profiling by calling zprof.
  [[ "$ZPROFRC" -eq 1 ]] && zprof
  [[ -v ZPROFRC ]] && unset ZPROFRC

  # Mark loaded.
  add-zsh-hook -d precmd zshrc-post
}

# Add hook so that zshrc-post is run in case the user forgot to.
autoload -Uz add-zsh-hook
add-zsh-hook precmd zshrc-post  # precmd is the only hook I know to use for this.
