export ZSH=$ZDOTDIR/plugins/oh-my-zsh

if [[ -z "$ZSH_CUSTOM" ]]; then
    ZSH_CUSTOM="$ZSH/custom"
fi

if [[ ! -d "$ZSH" ]]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git --depth=1 "$ZSH"
fi

# load omz plugins
omz_plugins=(
  colored-man-pages
  dirpersist
)
dirstack_file=${dirstack_file:-${ZDOTDIR}/.zdirs}

for plugin ($omz_plugins); do
  if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
  elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
  fi
done

unset plugin
unset omz_plugins
