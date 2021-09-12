ZPREZTODIR="${ZDOTDIR:-$HOME}/.zprezto"
if [[ ! -d "$ZPREZTODIR" ]]; then
  git clone --depth 1 --recursive --shallow-submodules https://github.com/sorin-ionescu/prezto.git "$ZPREZTODIR"
fi

# store plugin list in .zplugins
# skip hash comments and empty lines
contrib_plugins=()
if [[ -f ${ZDOTDIR:-$HOME}/.zplugins ]]; then
  contrib_plugins=("${(@f)$(awk '!/^(#| *$)/' ${ZDOTDIR:-$HOME}/.zplugins)}")
fi

for repo in $contrib_plugins; do
  plugin_name=${repo#*/}
  plugin_dir="$ZPREZTODIR/contrib/$plugin_name"

  if [[ ! -d "$plugin_dir" ]]; then
    mkdir -p "$ZPREZTODIR/contrib"
    git clone --depth 1 --recursive --shallow-submodules https://github.com/$repo.git "$plugin_dir"

    if [[ ! -f "$plugin_dir/init.zsh" ]]; then
      pushd
      cd "$plugin_dir"
      search_files=(
        # look for specific files first
        $plugin_name.plugin.zsh(.N)
        $plugin_name.zsh(.N)
        $plugin_name(.N)
        $plugin_name.zsh-theme(.N)
        # then do more aggressive globbing
        *.plugin.zsh(.N)
        *.zsh(.N)
        *.zsh-theme(.N)
        *.sh(.N)
      )
      if [[ ${#search_files[@]} -gt 0 ]]; then
        ln -s "${search_files[1]}" "init.zsh"
      fi
      popd
    fi
  fi
done
unset repo plugin_name plugin_dir search_files contrib_plugins

# plugin variables
PURE_PROMPT_SYMBOL="%%"

source "$ZPREZTODIR/init.zsh"
