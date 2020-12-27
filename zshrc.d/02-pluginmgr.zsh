# # get znap if we don't have it
# ZPLUGINSDIR="${ZDOTDIR:-$HOME/.config/zsh}"/plugins
# [[ -d $ZPLUGINSDIR/zsh-snap ]] ||
#   git clone --depth=1 --recursive https://github.com/marlonrichert/zsh-snap.git $ZPLUGINSDIR/zsh-snap

# # load znap if we haven't
# (( $+functions[znap] )) || {
#   zstyle ':znap:*' plugins-dir $ZPLUGINSDIR
#   # zstyle ':znap:*' auto-compile-ignore "${ZDOTDIR:-$HOME}/.z*" "${ZDOTDIR:-$HOME}/zfunctions/*" "${ZDOTDIR:-$HOME}/zshrc.d/*"
#   zstyle ':znap:*' auto-compile no
#   source $ZPLUGINSDIR/zsh-snap/znap.zsh
# }


ZPLUGR_PLUGINS_DIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
[[ -d $ZPLUGR_PLUGINS_DIR/zplugr ]] ||
  git clone --depth=1 --recursive https://github.com/mattmc3/zplugr.git $ZPLUGR_PLUGINS_DIR/zplugr
source $ZPLUGR_PLUGINS_DIR/zplugr/zplugr.zsh
