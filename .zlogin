#
# .zlogin - execute login commands post-zshrc
#
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zlogin

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  : ${ZSH_COMPDUMP:=${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump}
  if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
    if command mkdir "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null; then
      zcompile "$ZSH_COMPDUMP"
      command rmdir "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null
    fi
  fi
} &!
