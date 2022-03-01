# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

[[ -d ${ZDOTDIR:-~}/.zephyr ]] ||
  git clone https://github.com/zshzoo/zephyr ${ZDOTDIR:-~}/.zephyr

# order matters
zplugins=(
  # 3rd party plugins
  zshzoo/magic-enter
  zshzoo/macos
  rummik/zsh-tailf
  peterhurford/up.zsh
  rupa/z
  zshzoo/prj
  joshskidmore/zsh-fzf-history-search
)
zstyle ':zephyr:load' additional-plugins $zplugins
zstyle ':zephyr:plugin:prompt' theme 'purez'
#zstyle ':zephyr:plugin:syntax-highlighting' defer 'no'
source ${ZDOTDIR:-~}/.zephyr/zephyr.zsh
#source ~/Projects/zshzoo/zephyr/zephyr.zsh

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
