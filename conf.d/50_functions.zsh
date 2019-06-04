# functions - only put things here that really should be loaded with each and
# every shell instance

up() {
  if [[ "$#" < 1 ]] ; then
    cd ..
  else
    local CDSTR=""
    for i in {1..$1} ; do
      CDSTR="../$CDSTR"
    done
    cd $CDSTR
  fi
}

shellname() {
  ps -p $$ -ocomm= | sed -E -e 's/^.*[\/\-]//'
}

if [[ -n $ZSH_VERSION ]]; then
  # 'ls' after 'cd'
  # https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
  function chpwd() {
    if [[ "$CDLS" == "true" ]]; then
      emulate -L zsh
      ls -FG
    fi
  }
fi
