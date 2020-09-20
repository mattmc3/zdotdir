export ANTIBODY_HOME="$ZDOTDIR/zplugins"
if [[ ! -f "$ZDOTDIR/zshrc.d/zsh_plugins.zsh" ]]; then
 envsubst < $ZDOTDIR/.zsh_plugins | antibody bundle > $ZDOTDIR/zshrc.d/zsh_plugins.zsh
 sed -i '' "s|$HOME|\$HOME|g" $ZDOTDIR/zshrc.d/zsh_plugins.zsh
 source $ZDOTDIR/zshrc.d/zsh_plugins.zsh
fi
