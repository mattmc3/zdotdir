# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# zephyr settings
zstyle ':zephyr:plugin:prompt:pure' show-exit-code 'yes'
# ZSH_THEME=lambda
# zstyle ':zephyr:plugin:prompt' theme 'omz'

# antidote config
ANTIDOTE_HOME=${ZDOTDIR:-~}/.zplugins
zstyle ':antidote:bundle' use-friendly-names 'yes'

# load antidote
if [[ ! $ZDOTDIR/.zsh_plugins.zsh -nt $ZDOTDIR/.zsh_plugins.txt ]]; then
  [[ -e $ZDOTDIR/.antidote ]] \
    || git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote
  (
    source $ZDOTDIR/.antidote/antidote.zsh
    antidote bundle <$ZDOTDIR/.zsh_plugins.txt >$ZDOTDIR/.zsh_plugins.zsh
  )
fi
source $ZDOTDIR/.zsh_plugins.zsh

# zephyr
# ZEPHYR_HOME=${ZDOTDIR:-~}/.zephyr
# [[ -e $ZEPHYR_HOME ]] || \
#   git clone --depth=1 https://github.com/mattmc3/zephyr $ZEPHYR_HOME
# # ZEPHYR_HOME=~/Projects/mattmc3/zephyr

# zephyr_plugins=(
#   environment
#   terminal
#   editor
#   history
#   directory
#   utility
#   prompt
#   macos
#   magic-enter
#   zfunctions
#   confd
#   completions
#   history-substring-search
#   autosuggestions
# )
# zstyle ':zephyr:load' plugins $zephyr_plugins
# source $ZEPHYR_HOME/zephyr.zsh

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
