#
# .zshenv - Zsh environment file, loaded always.
#

# Even with $ZDOTDIR set, ~/.zshenv is still required.
# It should only be a one-liner containing: `. ~/.config/zsh/.zshenv`
# $ echo '. ~/.config/zsh/.zshenv' >| ~/.zshenv

# Put ZSH in a better spot (minus .zshenv)
export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}

# Set XDG dirs
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_CACHE_HOME=~/.cache

# Ensure XDG dirs exist on new systems.
for _xdgdir in XDG_{CONFIG,DATA,CACHE}_HOME; do
  [[ -d ${(P)_xdgdir} ]] || mkdir -p ${(P)_xdgdir}
done
unset _xdgdir

# Set common vars.
export EDITOR='hx'
export VISUAL='code'
export PAGER='less'
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi
export LESS='-g -i -M -R -S -w -z-4'

# Set paths.
typeset -gU fpath path
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# vim: ft=zsh sw=2 ts=2 et
