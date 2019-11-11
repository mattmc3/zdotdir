# fish-like abbr expansions
# https://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
# http://www.math.cmu.edu/~gautam/sj/blog/20140625-zsh-expand-alias.html
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/globalias/globalias.plugin.zsh
# https://gist.github.com/Frost/6ee5308103c43638ed7af493c8df702d
# https://github.com/zshzoo/zsh-abbrev-alias
ABBRS=()

function abbr() {
  alias $1
  ABBRS+=(${1%%\=*})
}

function expand-abbr() {
  if (($ABBRS[(Ie)$LBUFFER])); then
    zle _expand_alias
    zle expand-word
  fi
  zle self-insert
}

zle -N expand-abbr

# space expands all abbreviations
bindkey -M emacs " " expand-abbr
bindkey -M viins " " expand-abbr

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space

## set up abbreviations
# git
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git
abbr gcm='git checkout master'
abbr gcd='git checkout develop'
abbr gcb='git checkout -b'
