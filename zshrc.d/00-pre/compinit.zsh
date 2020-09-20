autoload -Uz compinit

# after adding everything we need to fpath, call run_compinit
run_compinit() {
  # https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L41
  # http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
  # https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
  setopt extendedglob local_options
  local zcd zcdc zdotdir
  zdotdir=${ZDOTDIR:-$HOME}
  zcd=${ZSH_COMPDUMP:-$zdotdir/.zcompdump}
  zcdc="$zcd.zwc"

  # Compile the completion dump to increase startup speed if dump is newer or
  # missing. Do in background for next time to not affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
    compinit -i -d "$zcd"
    { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
    compinit -i -C -d "$zcd"
    { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}
