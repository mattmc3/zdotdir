# execute 'ZPROF_ENABLE=1 zsh' and run 'zprof' to get profiler details
alias zperf='ZPROF_ENABLE=1 zsh'
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'
if [[ $ZPROF_ENABLE -gt 0 ]] ; then
  zmodload zsh/zprof
  echo 'now run `zprof` to profile...'
fi

# setup zgen as plugin manager
export ZGEN_DIR="${ZDOTDIR:-$HOME}"/.zgen
[[ -d "$ZGEN_DIR" ]] || git clone --depth 1 https://github.com/tarjoilija/zgen.git "$ZGEN_DIR"
ZGEN_RESET_ON_CHANGE=(${ZDOTDIR:-$HOME}/.zshrc ${ZDOTDIR:-$HOME}/zplugins)
ZGEN_AUTOLOAD_COMPINIT=false
ZSH="$ZGEN_DIR/robbyrussell/oh-my-zsh-master"

# load plugins
source "$ZGEN_DIR/zgen.zsh"
if ! zgen saved; then
  # clone things we don't need to load directly
  zgen clone robbyrussell/oh-my-zsh

  # use zplugins file for other plugins if it exists
  if [[ -f $ZDOTDIR/zplugins ]]; then
    zgen loadall < $ZDOTDIR/zplugins
  fi

  # save zgen plugins into init.zsh
  zgen save
fi

# set the prompt
prompt lean

# .zshrc.local machine level config (do not add to git)
[[ -f "${ZDOTDIR:-HOME}"/.zshrc.local ]] && . "${ZDOTDIR:-HOME}"/.zshrc.local
