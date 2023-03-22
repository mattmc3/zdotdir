#
# misc - Set general Zsh config options here, or change plugin settings.
#


#
# Options
#

# Fix/reset bad plugin options.
setopt NO_BEEP       # Be quiet!
setopt NO_HIST_BEEP  # Be quiet!


#
# antidote
#

[[ -n "$ANTIDOTE_HOME" ]] || ANTIDOTE_HOME="$(antidote home)"


#
# misc
#

# pyenv

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# local/bin

export PATH="$PATH:/home/ngesing/.local/bin"

# execute plugin functions
init-zabbr
init-zshz
init-magic-enter
init-autosuggestions
init-history-substring-search
