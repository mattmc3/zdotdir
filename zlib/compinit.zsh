# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L44
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zlogin#L9-L15
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
# https://htr3n.github.io/2018/07/faster-zsh/
function run_compinit() {
  # run compinit in a smarter, faster way
  emulate -L zsh
  setopt localoptions extendedglob

  ZSH_COMPDUMP=${ZSH_COMPDUMP:-$XDG_CACHE_HOME/zsh/zcompdump}
  [[ -d "$ZSH_COMPDUMP:h" ]] || mkdir -p "$ZSH_COMPDUMP:h"
  autoload -Uz compinit

  # if compdump is less than 20 hours old,
  # consider it fresh and shortcut it with `compinit -C`
  #
  # Glob magic explained:
  #   #q expands globs in conditional expressions
  #   N - sets null_glob option (no error on 0 results)
  #   mh-20 - modified less than 20 hours ago
  if [[ "$1" != "-f" ]] && [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
    # -C (skip function check) implies -i (skip security check).
    compinit -C -d "$ZSH_COMPDUMP"
  else
    compinit -i -d "$ZSH_COMPDUMP"
    touch "$ZSH_COMPDUMP"
  fi

  # Compile zcompdump, if modified, in background to increase startup speed.
  {
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
      zcompile "$ZSH_COMPDUMP"
    fi
  } &!
}
run_compinit
