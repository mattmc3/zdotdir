# antigen
export ADOTDIR="${ADOTDIR:-$XDG_DATA_HOME/antigen}"

[[ -d "$ADOTDIR" ]] || mkdir -p "$ADOTDIR"
[[ -f "$ADOTDIR"/antigen.zsh ]] || curl -L git.io/antigen > "$ADOTDIR"/antigen.zsh
source "$ADOTDIR"/antigen.zsh

export ZSH=$ADOTDIR/plugins/bundles/robbyrussell/oh-my-zsh

antigen use oh-my-zsh

# themes I like: refined, wezm, juanghurtado, avit, kardan, juanghurtado, steeef
antigen theme avit

# antigen can init via heredocs
antigen bundles <<EOBUNDLES

colored-man-pages
common-aliases
extract
# history
# osx
# python
# golang

rupa/z
mafredri/zsh-async
arzzen/calc.plugin.zsh

zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
zsh-users/zsh-completions

# # themes
# sindresorhus/pure
# denysdovhan/spaceship-prompt

EOBUNDLES
antigen apply
