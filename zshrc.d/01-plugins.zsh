# drive zsh with plugins
# this uses a simple antibody replacement utility called "plugin" in $ZDOTDIR/functions
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-~}/.zplugins}
path=($ZDOTDIR/bin $path)

# if [[ ! -f $ZPLUGINDIR/init.zsh ]]; then
#   mkdir -p $ZPLUGINDIR
#   envsubst < ${ZDOTDIR:-~}/.zpluginrc | plugin bundle >| $ZPLUGINDIR/init.zsh
#   sed -i '' "s|$HOME|\$HOME|g" $ZPLUGINDIR/init.zsh
# fi
plugin loadall

#ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/.zabbrs
MAGIC_ENTER_GIT_COMMAND="git status -sb"
MAGIC_ENTER_OTHER_COMMAND="ls -G"

# fix prezto settings
(( ${+aliases[man]} )) && unalias man
