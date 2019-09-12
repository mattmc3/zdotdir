#
# startup file read in interactive login shells
#
# The following code helps us by optimizing the existing framework.
# This includes zcompile, zcompdump, etc.
#
# https://github.com/zimfw/zimfw/blob/master/login_init.zsh
#
(
  local dir file zdotdir
  zdotdir=${ZDOTDIR:-${HOME}}
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  autoload -U zrecompile

  # zcompile the completion cache; siginificant speedup
  zrecompile -pq $zdotdir/${zcompdump_file:-.zcompdump}

  # zcompile .zshrc
  zrecompile -pq $zdotdir/.zshrc
  zrecompile -pq $zdotdir/zshrc.zsh

  # zcompile enabled module autoloaded functions
  for dir in $zdotdir/plugins/**/functions(/FN); do
    zrecompile -pq ${dir}.zwc ${dir}/^(_*|prompt_*_setup|*.*)(-.N)
  done

  # zcompile scripts
  for file in $zdotdir/plugins/**/(^*test*/)#*.zsh{,-theme}(.NLk+1); do
    zrecompile -pq ${file}
  done

  # zcompile conf.d
  for file in $zdotdir/conf.d/**/*.zsh(.N); do
    zrecompile -pq ${file}
  done
) &!
