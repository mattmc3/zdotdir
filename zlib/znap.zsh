# setup znap
PLUGIN_HOME="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
zstyle ':znap:*' plugins-dir $PLUGIN_HOME
zstyle ':znap:*' auto-compile no

# get znap
[[ -d $PLUGIN_HOME/zsh-snap ]] ||
   git clone --depth=1 --recursive https://github.com/marlonrichert/zsh-snap.git $PLUGIN_HOME/zsh-snap
source $PLUGIN_HOME/zsh-snap/znap.zsh

znap source mafredri/zsh-async
znap prompt sindresorhus/pure

# regular plugins
znap source mattmc3/zsh-setopts
znap source mattmc3/zsh-history
znap source mattmc3/zfunctions
znap source mattmc3/zsh-xdg-basedirs
znap source olets/zsh-abbr
znap source mattmc3/zsh-cd-ls
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-history-substring-search
znap source rupa/z

# omz plugins
znap source ohmyzsh/ohmyzsh plugins/colored-man-pages

# last plugins
znap source mattmc3/zshrc.d
znap source mattmc3/zsh-compinit
znap source zsh-users/zsh-syntax-highlighting
znap source zdharma/fast-syntax-highlighting
