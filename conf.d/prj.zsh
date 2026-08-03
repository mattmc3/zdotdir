#
# prj: Project jumper
#

_prj_bin=(
  /opt/homebrew/bin/prj(N)
  $HOME/bin/prj(N)
)

if (( $#_prj_bin )); then
    if (( $+functions[cached-eval] )); then
    cached-eval $_prj_bin[1] -i zsh
  else
    eval "$($_prj_bin[1] -i zsh)"
  fi
fi
unset _prj_bin
