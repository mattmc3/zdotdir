source <(antibody init)
antibody bundle < $ZDOTDIR/conf.d/20_plugins.txt

# post-activities after plugins load

# to handle autosuggest fg=8 blending with terminal background
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# spaceship prompt config
# https://github.com/denysdovhan/spaceship-prompt
# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md
SPACESHIP_CHAR_SYMBOL='%% '
