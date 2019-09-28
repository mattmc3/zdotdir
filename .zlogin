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

  # zcompile antibody plugins
  for file in $zdotdir/.antibody/**/*.zsh(.N); do
    zrecompile -pq ${file}
  done

  # zcompile zgen plugins
  for file in $zdotdir/.zgen/**/*.zsh(.N); do
    zrecompile -pq ${file}
  done

  # zcompile conf.d
  for file in $zdotdir/conf.d/**/*.zsh(.N); do
    zrecompile -pq ${file}
  done

  # if we're using oh-my-zsh, compile all that stuff
  if [[ -d $ZSH ]]; then
    [[ -d $ZSH_CUSTOM ]] || ZSH_CUSTOM="$ZSH/custom"

    # zcompile root OMZ
    zrecompile -pq $ZSH/oh-my-zsh.sh

    # zcompile root omz lib
    for file in {$ZSH,$ZSH_CUSTOM}/lib/*.zsh(.N); do
      zrecompile -pq ${file}
    done

    # zcompile enabled omz-plugins
    if [ -n "$plugins" ]; then
      for file in {$ZSH,$ZSH_CUSTOM}/plugins/${^plugins}/**/*.zsh{,-theme}(.N); do
        zrecompile -pq ${file}
      done
    fi

    # zcompile theme
    if [ -n "$ZSH_THEME" ]; then
      for file in {$ZSH,$ZSH_CUSTOM}/themes/$ZSH_THEME.zsh-theme(.N); do
        zrecompile -pq ${file}
      done
    fi

    # clean our mess
    find $ZSH -type f -name "*.zwc.old" -delete
    [[ -d $ZSH_CUSTOM ]] && find $ZSH_CUSTOM -type f -name "*.zwc.old" -delete
  fi

  # cleanup
  find ${ZDOTDIR:-$HOME} -type f -name "*.zwc.old" -maxdepth 1 -delete
) &!
