# functions - only put things here that really should be loaded with each and
# every shell instance

export CDLS=${CDLS:-true}

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

fpath=("$ZDOTDIR"/functions $fpath);
autoload -U "$ZDOTDIR"/functions/*(.:t)
