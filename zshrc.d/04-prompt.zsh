PURE_PROMPT_SYMBOL="%%"

PROMPT_REPOS=(
  sindresorhus/pure
  miekg/lean
  agnoster/agnoster-zsh-theme
  # romkatv/powerlevel10k
)

# make all prompts available in `prompt -l`
fpath+="$ZDOTDIR/plugins"
for _repo in $PROMPT_REPOS; do
  _prompt_name=${${_repo##*/}%.git}
  [[ -d "$ZDOTDIR/plugins/$_prompt_name" ]] ||
    zplugr clone $_repo
  fpath+="$ZDOTDIR/plugins/$_prompt_name"
done
unset _repo _prompt_name

if [[ $ZPROF == "true" || "${LAZY_PROMPT:-true}" == "false" ]]; then
  autoload -U promptinit; promptinit
  prompt "${ZSH_PROMPT:-pure}"
else
  zplugr prompt sindresorhus/pure
fi
