# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

[[ -d ${ZDOTDIR:-~}/.zephyr ]] ||
  git clone https://github.com/zshzoo/zephyr ${ZDOTDIR:-~}/.zephyr

# order matters
zplugins=(
  # 3rd party plugins
  mattmc3/zman
  zshzoo/magic-enter
  zshzoo/macos
  rummik/zsh-tailf
  peterhurford/up.zsh
  rupa/z

  # zephyr built-in plugins
  environment
  terminal
  editor
  history
  directory
  utility
  prompt
  zfunctions
  confd
  completions
  history-substring-search
  autosuggestions
)
deferplugins=(
  olets/zsh-abbr
  zdharma-continuum/fast-syntax-highlighting
)

zstyle ':zephyr:load' plugins $zplugins
zstyle ':zephyr:defer' plugins $deferplugins
source ${ZDOTDIR:-~}/.zephyr/zephyr.zsh
#source ~/Projects/zshzoo/zephyr/zephyr.zsh
prompt pure

# local settings
[[ -f $ZDOTDIR/.zshrc.local ]] && source $ZDOTDIR/.zshrc.local
[[ -f $ZDOTDIR/functions.local ]] && autoload-dir $ZDOTDIR/functions.local

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
