# zprof if we ever need to profile
alias runzprof="ZPROF=true zsh"
[[ $ZPROF != true ]] || zmodload zsh/zprof
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'

# zlib pre
source $ZDOTDIR/zlib/environment.zsh
source $ZDOTDIR/zlib/pre-plugins.zsh

# setup pz as our plugin manager
PZ_PLUGIN_HOME="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
[[ -d $PZ_PLUGIN_HOME/pz ]] ||
  git clone --depth=1 --recursive https://github.com/mattmc3/pz.git $PZ_PLUGIN_HOME/pz
# source $PZ_PLUGIN_HOME/pz/pz.zsh
source ~/Projects/mattmc3/pz/pz.zsh

# prompts
pz prompt -a miekg/lean
# ZSH_THEME=refined
# pz source mattmc3/omz-themes-standalone
pz prompt sindresorhus/pure

# regular plugins
pz source mattmc3/zsh-setopts
pz source mattmc3/zsh-history
pz source mattmc3/zfunctions
pz source mattmc3/zsh-xdg-basedirs
pz source olets/zsh-abbr
pz source mattmc3/zsh-cd-ls
pz source zsh-users/zsh-autosuggestions
pz source zsh-users/zsh-completions
pz source zsh-users/zsh-history-substring-search
pz source rupa/z

# omz plugins
pz source ohmyzsh/ohmyzsh plugins/colored-man-pages

# last plugins
pz source mattmc3/zshrc.d
pz source mattmc3/zsh-compinit
pz source zsh-users/zsh-syntax-highlighting

# zlib post
source $ZDOTDIR/zlib/post-plugins.zsh
source $ZDOTDIR/zlib/local.zsh

# done profiling
[[ $ZPROF != true ]] || { unset ZPROF && zprof }
