# functions - only put things here that really should be loaded with each and
# every shell instance

export CD_LS=${CD_LS:-true}

# 'ls' after 'cd'
# https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
  if [[ "$CD_LS" == "true" ]]; then
    emulate -L zsh
    ls -FG
  fi
}
