# Abbreviations config.
ABBR_USER_ABBREVIATIONS_FILE=${ABBR_USER_ABBREVIATIONS_FILE:-${ZDOTDIR:-~}/.zabbr}

# Autosuggestions config.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi

# History substring search config.
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Pure config.
PURE_PROMPT_SYMBOL="%%"
# show exit code on right
function precmd_pipestatus {
  local exitcodes="${(j.|.)pipestatus}"
  if [[ "$exitcodes" != "0" ]]; then
    RPROMPT="%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f"
  else
    RPROMPT=
  fi
}
add-zsh-hook precmd precmd_pipestatus

# Z config.
_Z_DATA=${XDG_DATA_HOME:=~/.local/share}/z/data
[[ -f $_Z_DATA ]] || { mkdir -p ${_Z_DATA:h} && touch $_Z_DATA }
