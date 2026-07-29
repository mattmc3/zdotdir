#
# prj: Project jumper
#

cmd_prj=(
  /opt/homebrew/bin/prj(N)
  $HOME/bin/prj(N)
)

if (( $#cmd_prj )); then
    if (( $+functions[cached-eval] )); then
    cached-eval $cmd_prj[1] -i zsh
  else
    eval "$($cmd_prj[1] -i zsh)"
  fi
fi
