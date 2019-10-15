### history ---------------------------------------------------------------- {{{
# options: http://zsh.sourceforge.net/Doc/Release/Options.html#History

# set for OMZ history lib
HIST_STAMPS="yyyy-mm-dd"

# omz
# [[ -f $ZSH/lib/history.zsh ]] && . $ZSH/lib/history.zsh
# [[ -f $ZSH/plugins/history/history.plugin.zsh ]] && . $ZSH/plugins/history/history.plugin.zsh

# fix OMZ settings to be better
SAVEHIST=100000
HISTSIZE=50000
HISTFILE="$XDG_DATA_HOME/zsh/history"
[[ -d "$XDG_DATA_HOME"/zsh ]] || mkdir -p "$XDG_DATA_HOME"/zsh

# it's nice to have the history file in your $ZDOTDIR, but don't store it there
if [[ -f "$HISTFILE" ]] && [[ ! -f "${ZDOTDIR}/.zhistory" ]]; then
  ln -s "$HISTFILE" "${ZDOTDIR}/.zhistory"
fi
