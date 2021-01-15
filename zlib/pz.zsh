# setup pz as our plugin manager
PZ_PLUGIN_HOME="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
[[ -d $PZ_PLUGIN_HOME/pz ]] ||
  git clone --depth=1 --recursive https://github.com/mattmc3/pz.git $PZ_PLUGIN_HOME/pz
source $PZ_PLUGIN_HOME/pz/pz.zsh
# source "$HOME/Projects/mattmc3/pz/pz.zsh"

# prompts
pz prompt -a miekg/lean
# ZSH_THEME=refined
# pz source mattmc3/omz-themes-standalone
pz source mafredri/zsh-async
pz prompt sindresorhus/pure

# regular plugins
pz source mattmc3/zsh-setopts
pz source mattmc3/zsh-history
pz source mattmc3/zfunctions
pz source mattmc3/zsh-xdg-basedirs
# pz source olets/zsh-abbr
pz source mattmc3/zsh-cd-ls
pz source zsh-users/zsh-autosuggestions
pz source zsh-users/zsh-completions
pz source zsh-users/zsh-history-substring-search
pz source rupa/z

# omz plugins
pz source ohmyzsh/ohmyzsh plugins/colored-man-pages

# prezto plugins
pz source sorin-ionescu/prezto modules/terminal
pz source sorin-ionescu/prezto modules/editor
setopt nobeep

# last plugins
pz source mattmc3/zshrc.d
pz source mattmc3/zsh-compinit
# pz source zsh-users/zsh-syntax-highlighting
pz source zdharma/fast-syntax-highlighting
