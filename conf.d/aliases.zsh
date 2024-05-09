#####
# My aliases
#
# References
# - https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# - https://github.com/webpro/dotfiles/blob/master/system/.alias
# - https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
#####

# special

alias nv="nvim"
alias lv="lvim"
alias cdj="rgf"
alias zalias='${EDITOR:-lvim} "${ZDOTDIR:-$HOME}"/conf.d/aliases.zsh; source "${ZDOTDIR:-$HOME}"/conf.d/aliases.zsh'
alias zfunc='function f(){ ${EDITOR:-lvim} "${ZDOTDIR:-$HOME}"/functions/${1};};f'
alias zfdir='cd $ZFUNCDIR'
alias kgsk="git squash"
alias gsk="function f(){ squash $1 $2; };f"
alias nvinit='${EDITOR:-lvim} "${NVIMCONFIG:-$HOME/.config/nvim}"/init.vim'
alias lvinit='${EDITOR:-lvim} "${LVIMCONFIG:-$HOME/.config/lvim}"/config.lua'
alias lvdot='cd ${LVIMCONFIG:-$HOME/.config/lvim}'
alias nvdot='cd ${NVIMCONFIG:-Home/.config/nvim}'
alias adot='cd ${ASTROCONFIG:-$HOME/.config/nvim/lua/user}'
alias ppath="echo "$PATH" | tr ':' '\n'"
alias ep='explorer.exe .'
alias delzone='find . -name "*:Zone.Identifier" -type f -delete'
alias lg='lazygit'
alias cdn="fuzzy-edit"
alias fo="fuzzy-edit -e"
alias fe="fuzzy-edit -e"
alias tardir="tar -zcvf"

# directory aliases

alias md="mkdir -p"
alias rd="rmdir"
alias -- -='cd -'
alias dirh='dirs -v'
dotdot=".."
for index ({1..9}); do
  alias "$index"="cd +${index}"
  alias -g "..$index"="$dotdot"
  dotdot+='/..'
done
unset index dotdot

# single character shortcuts - be sparing!
alias _=sudo
alias l=ls
alias o=open
alias g=git

# mask built-ins with better defaults
alias ping='ping -c 5'
alias vi=vim

GREP_EXCL=(.bzr CVS .git .hg .svn .idea .tox)
alias grep="${aliases[grep]:-grep} --exclude-dir={\${(j.,.)GREP_EXCL}}"

# more ways to ls
alias ll='ls -lh'
alias la='ls -lAh'
alias ldot='ls -ld .*'

# fix typos
alias quit='exit'
alias cd..='cd ..'
alias zz='exit'

# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# date/time
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias utc="date -u +%Y-%m-%dT%H:%M:%SZ"
alias unixepoch="date +%s"

# find
alias fdir='find . -type d -name'
alias ff='find . -type f -name'

# disk usage
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# misc
alias please=sudo
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias zdot='cd $ZDOTDIR'
alias fdot='cd ${XDG_CONFIG_HOME:-$HOME/.config}/fish'
alias cls="clear && printf '\e[3J'"

# echo things
alias print-fpath='for fp in $fpath; do echo $fp; done; unset fp'
alias print-path='echo $PATH | tr ":" "\n"'
alias print-functions='print -l ${(k)functions[(I)[^_]*]} | sort'

# auto-orient images based on exif tags
alias autorotate="jhead -autorot"

# set initial working directory
IWD=${IWD:-$PWD}
alias iwd='cd $IWD'

# dotfiles
alias dotf='cd "$DOTFILES"'
alias dotfed='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'

# java
alias setjavahome="export JAVA_HOME=\`/usr/libexec/java_home\`"

# python
alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pipup="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

# user specific aliases and functions
if [[ -f "$USER_CONFIG/aliases.zsh" ]]; then
  source "$USER_CONFIG/aliases.zsh"
fi
