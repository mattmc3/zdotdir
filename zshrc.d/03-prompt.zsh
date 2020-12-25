PURE_PROMPT_SYMBOL="%%"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# [[ -d "$ZDOTDIR/plugins/pure" ]] ||
#   git clone https://github.com/sindresorhus/pure.git "$ZDOTDIR/plugins/pure"
# fpath+="$ZDOTDIR/plugins/pure"
# autoload -U promptinit; promptinit
# prompt pure

ZSH_PROMPT="${ZSH_PROMPT:-pure}"
PROMPT_REPOS=(
  sindresorhus/pure
  miekg/lean
  agnoster/agnoster-zsh-theme
  romkatv/powerlevel10k
)

fpath+="$ZDOTDIR/plugins"
for _repo in $PROMPT_REPOS; do
  _prompt_name=${${_repo##*/}%.git}
  [[ -d "$ZDOTDIR/plugins/$_prompt_name" ]] ||
    plugin clone $_repo
  fpath+="$ZDOTDIR/plugins/$_prompt_name"
done
unset _repo _prompt_name

# https://github.com/marlonrichert/zsh-snap/issues/15
# if [[ $ZPROF != true ]]; then
#   plugin prompt $ZSH_PROMPT
# else
#   autoload -U promptinit; promptinit
#   prompt $ZSH_PROMPT
# fi

# Needed for P10k prompt
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

autoload -U promptinit; promptinit
prompt $ZSH_PROMPT
