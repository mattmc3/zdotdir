#
# aliases.zsh
#

# https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# https://github.com/webpro/dotfiles/blob/master/system/.alias
# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh

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
alias zbench='for i in $(seq 10); do; /usr/bin/time zsh -lic exit; done'
alias zprofrc="ZPROFRC=1 zsh"
alias zdot='cd $ZDOTDIR'
alias confd='cd $HOME/.config'
alias proj='cd $HOME/Projects'

# zsh pipes
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep -E'
alias -g S='| sort'
alias -g L='| less'
alias -g M='| more'

# echo things
alias print-fpath='for fp in $fpath; do echo $fp; done; unset fp'
alias print-path='echo $PATH | tr ":" "\n"'
alias print-functions='print -l ${(k)functions[(I)[^_]*]} | sort'

# mask built-ins with better defaults
alias cp='cp -i'
alias mv='mv -i'
#alias rm='rm -i'
alias ls='ls -G'
alias mkdir="mkdir -p"
alias ping='ping -c 5'
alias type="type -a"

#GREP_EXCL=(.bzr CVS .git .hg .svn .idea .tox .vscode)
#alias grep="${aliases[grep]:-grep} --color=auto --exclude-dir={\${(j.,.)GREP_EXCL}}"

# single character shortcuts - be sparing!
alias _='sudo'

# macOS utils everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
elif [[ "$OSTYPE" == linux-android ]]; then
  alias o='termux-open'
  alias pbcopy='termux-clipboard-set'
  alias pbpaste='termux-clipboard-get'
else
  alias o='xdg-open'

  if [[ -n $DISPLAY ]]; then
    if (( $+commands[xclip] )); then
      alias pbcopy='xclip -selection clipboard -in'
      alias pbpaste='xclip -selection clipboard -out'
    elif (( $+commands[xsel] )); then
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'
    fi
  else
    if (( $+commands[wl-copy] && $+commands[wl-paste] )); then
      alias pbcopy='wl-copy'
      alias pbpaste='wl-paste'
    fi
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

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
alias speedtest="wget -O /dev/null http://speed.transip.nl/10mb.bin"
alias pinging="command ping"

# other aliases
alias tarls="tar -tvf"
alias untar="tar -xf"
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias linecount="grep -c '^'"
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# auto-orient images based on exif tags
alias autorotate="jhead -autorot"

alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'
