# ### antibody {{{
# source <(antibody init)
# antibody bundle < $ZDOTDIR/conf.d/20_antibody_plugins.txt

# # post-activities after plugins load

# # to handle autosuggest fg=8 blending with terminal background
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# # spaceship prompt config
# # https://github.com/denysdovhan/spaceship-prompt
# # https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md
# SPACESHIP_CHAR_SYMBOL='%% '
# ### }}}


### antigen {{{
export ADOTDIR="$ZDOTDIR"/.antigen
if [[ ! -f "$ADOTDIR"/antigen.zsh ]]; then
  mkdir -p "$ADOTDIR"
  curl -L git.io/antigen > "$ADOTDIR"/antigen.zsh
fi
source "$ADOTDIR"/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load the theme
# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
antigen theme terminalparty

# in case anything can take advantage of async
antigen bundle mafredri/zsh-async

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle colored-man-pages
antigen bundle extract
antigen bundle python

antigen bundle rupa/z
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions

# these should be at last!
# antigen bundle sindresorhus/pure
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Tell Antigen that you're done.
antigen apply
### }}}
