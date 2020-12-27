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


PZ_PLUGINS_DIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
[[ -d $PZ_PLUGINS_DIR/pz ]] ||
  git clone --depth=1 --recursive https://github.com/mattmc3/pz.git $PZ_PLUGINS_DIR/pz
source $PZ_PLUGINS_DIR/pz/pz.zsh
