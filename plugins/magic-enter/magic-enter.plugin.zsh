: ${ZSH:=$ZPLUGINDIR/.external/ohmyzsh}
source $ZSH/plugins/magic-enter/magic-enter.plugin.zsh

MAGIC_ENTER_GIT_COMMAND='git status -sb'
if [[ "$OSTYPE" == darwin* ]]; then
  MAGIC_ENTER_OTHER_COMMAND='command ls -G'
else
  MAGIC_ENTER_OTHER_COMMAND='command ls --color=auto'
fi
