### aliases ---------------------------------------------------------------- {{{
# https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# https://github.com/webpro/dotfiles/blob/master/system/.alias
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases

# zsh only aliases
if [[ -n $ZSH_VERSION ]]; then
  alias 1='cd -'
  alias 2='cd -2'
  alias 3='cd -3'
  alias 4='cd -4'
  alias 5='cd -5'
  alias 6='cd -6'
  alias 7='cd -7'
  alias 8='cd -8'
  alias 9='cd -9'

  alias cd..='cd ..'
  alias -g ..2='../..'
  alias -g ..3='../../..'
  alias -g ..4='../../../..'
  alias -g ..5='../../../../..'
  alias -g ...='../..'
  alias -g ....='../../..'
  alias -g .....='../../../..'
  alias -g ......='../../../../..'

  alias zshrc='$VISUAL "${ZDOTDIR:-$HOME}"/.zshrc'
  alias reload='source "${ZDOTDIR:-$HOME}"/.zshrc'
  alias zbench='export LAZY_PROMPT=false; for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done; unset LAZY_PROMPT'
  alias zdot='cd $ZDOTDIR'

  # zsh pipes
  alias -g H='| head'
  alias -g T='| tail'
  alias -g G='| grep -E'
  alias -g S='| sort'
  alias -g L='| less'
  alias -g M='| more'
fi

# mask built-ins with better defaults
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'
alias ls='ls -GF'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ping='ping -c 5'

# be safe
alias cpi='cp -i'
alias mvi='mv -i'
alias rmi='rm -i'

# single character shortcuts - be sparing!
alias _='sudo'
alias c='clear'
alias d='dirs -v | head -10'
alias v='vim'
alias h='history'

# shortcuts
alias vi='vim'
alias nv='nvim'
alias afind='ack -il'
alias md='mkdir -p'
alias rd=rmdir
alias please=sudo
alias po=popd
alias pu=pushd
alias globurl='noglob urlglobber '
alias zz=exit

# more ways to ls
alias ll='ls -lFh'
alias l='ls -F'
alias la='ls -lAFh'
alias ldot='ls -ld .*'

# fix typos
alias quit='exit'

# tools
alias te="$EDITOR"
alias ide="$VISUAL"

# network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias dnsflush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias speedtest="wget -O /dev/null http://speed.transip.nl/10mb.bin"
alias pinging="command ping"

# other aliases
alias tarls="tar -tvf"
alias untar="tar -xf"
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias path='echo -e ${PATH//:/\\n}'
alias linecount="grep -c '^'"
alias ds="date +%Y%m%d"
alias ts="date +%Y%m%d%H%M%S"
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# auto-orient images based on exif tags
alias autorotate="jhead -autorot"
