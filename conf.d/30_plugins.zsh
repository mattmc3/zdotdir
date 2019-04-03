# antigen
export ADOTDIR="${ADOTDIR:-$XDG_DATA_HOME/antigen}"

[[ -d "$ADOTDIR" ]] || mkdir -p "$ADOTDIR"
[[ -f "$ADOTDIR"/antigen.zsh ]] || curl -L git.io/antigen > "$ADOTDIR"/antigen.zsh
source "$ADOTDIR"/antigen.zsh

# tell antigen to monitor the following files for changes
typeset -a ANTIGEN_CHECK_FILES=("$ZDOTDIR"/.zshrc "$ADOTDIR"/antigen.zsh "$ZDOTDIR"/conf.d/*.zsh "$ZDOTDIR"/conf.d/*.sh)

export ZSH=$ADOTDIR/plugins/bundles/robbyrussell/oh-my-zsh

antigen use oh-my-zsh

# omz themes I like:
#   refined, wezm, juanghurtado, avit, kardan, juanghurtado, steeef
# 3rd party themes:
#   sindresorhus/pure
#   denysdovhan/spaceship-prompt
antigen theme denysdovhan/spaceship-prompt

# antigen can init via heredocs
antigen bundles <<EOBUNDLES

colored-man-pages
common-aliases
extract
# history
# osx
python
# golang

rupa/z
mafredri/zsh-async
# arzzen/calc.plugin.zsh

zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
zsh-users/zsh-completions

EOBUNDLES
antigen apply

# fixes for plugins
alias ls='ls -GF'
export LSCOLORS=ExFxBxDxCxegedabagacad
