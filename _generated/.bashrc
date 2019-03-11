# generated via makefile\n
# XDG
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory

# Make sure XDG dirs are set
[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME=$HOME/.config
[[ -n "$XDG_CACHE_HOME"  ]] || export XDG_CACHE_HOME=$HOME/.cache
[[ -n "$XDG_DATA_HOME"   ]] || export XDG_DATA_HOME=$HOME/.local/share
[[ -n "$XDG_RUNTIME_DIR" ]] || export XDG_RUNTIME_DIR=$HOME/.xdg

function _ensure_file() {
	# ensure the file exists
	[[ -f "$1" ]] || { mkdir -p "${1%/*}" && touch "$1" }
}

if [[ -n $ZSH_VERSION ]]; then
	SHELLNAME="zsh"
elif [[ -n $BASH_VERSION ]]; then
	SHELLNAME="bash"
fi

# re-home app data to ~/.local/share
HISTFILE="${XDG_DATA_HOME}/${SHELLNAME}/${SHELLNAME}_history" && _ensure_file "$HISTFILE"
export LESSHISTFILE="${XDG_DATA_HOME}/less/lesshst" && _ensure_file "$LESSHISTFILE"
# exports
[[ -n "$TZ" ]] || export TZ=America/New_York
[[ -n "$TERM" ]] || export TERM=xterm-256color

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	# https://help.github.com/articles/associating-text-editors-with-git/
	# export EDITOR="subl -n -w"
	export EDITOR='nvim'
fi
export VISUAL='code'
export PAGER='less'

if [[ -n $ZSH_VERSION ]]; then
	# Set path
	path=(
		$HOME/bin
		/usr/local/{sbin,bin}
		/usr/local/share/npm/bin
		/usr/{sbin,bin}
		/{sbin,bin}
		$path
	)

	typeset -gxU path
fi
if [[ -n $ZSH_VERSION ]]; then
	# http://zsh.sourceforge.net/Doc/Release/Options-Index.html

	SAVEHIST=10000
	HISTSIZE=10000

	setopt APPEND_HISTORY
	setopt EXTENDED_HISTORY
	setopt HIST_EXPIRE_DUPS_FIRST
	setopt HIST_FIND_NO_DUPS
	setopt HIST_IGNORE_DUPS
	setopt HIST_IGNORE_SPACE
	setopt HIST_REDUCE_BLANKS
	setopt HIST_VERIFY
	setopt INC_APPEND_HISTORY
	setopt NO_HIST_BEEP
	setopt SHARE_HISTORY
fi
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
	alias zshrc='ide "${ZDOTDIR:-$HOME}"/.zshrc'
	alias reload='source "${ZDOTDIR:-$HOME}"/.zshrc'

	# zsh pipes
	alias -g H='| head'
	alias -g T='| tail'
	alias -g G='| grep -E'
	alias -g S='| sort'
	alias -g L='| less'
	alias -g M='| more'

elif [[ -n $BASH_VERSION ]]; then
	alias s="source ~/.bashrc"  # quick sourcing
	alias reload="source ~/.bashrc"
fi

# mask built-ins with better defaults
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -GF'
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ping='ping -c 5'

# be safe
alias cpi='cp -i'
alias mvi='mv -i'
alias rmi='rm -i'

#alias rm='echo "STOP using rm! Use \"safe-rm\" instead. Removing anyway." && safe-rm "$@"'
alias del='safe-rm -i'

# single character shortcuts - be sparing!
alias _='sudo'
alias c='clear'
alias d='dirs -v | head -10'
alias g='git'
alias v='nvim'
alias h='history'

# shortcuts
alias vi='nvim'
alias vim='nvim'
alias oldvim='\vim'
alias cl='clear'
alias py2='python2'
alias py3='python3'
alias py='python3'
alias afind='ack -il'
alias md='mkdir -p'
alias rd=rmdir
alias please=sudo
alias po=popd
alias pu=pushd
alias zz=exit
alias globurl='noglob urlglobber '

# ls
alias ll='ls -lFh'
alias l='ls -F'
alias la='ls -lAFh'
alias ldot='ls -ld .*'

# fix typos
alias cs='cd'  # darn colemak
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
alias ex="exit"
alias ds="date +%Y%m%d"
alias ts="date +%Y%m%d%H%M%S"
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias dud='du -d 1 -h'
alias duf='du -sh *'
# functions - only put things here that really should be loaded with each and
# every shell instance

up() {
	if [[ "$#" < 1 ]] ; then
		cd ..
	else
		local CDSTR=""
		for i in {1..$1} ; do
			CDSTR="../$CDSTR"
		done
		cd $CDSTR
	fi
}

shellname() {
	ps -p $$ -ocomm= | sed -E -e 's/^.*[\/\-]//'
}

username() {
	id -un
}

# benchmark
function benchmark() {
	for ((n=0;n<10;n++)); do
		if [[ -n $ZSH_VERSION ]]; then
			/usr/bin/time zsh -i -c exit
		elif [[ -n $BASH_VERSION ]]; then
			/usr/bin/time bash -i -c exit
		fi
	done
}

if [[ -n $ZSH_VERSION ]]; then
	# 'ls' after 'cd'
	# https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
	function chpwd() {
		emulate -L zsh
		ls -FG
	}
fi
# apps
# apps is for anything that isn't directly shell related that I might be using.
# git, python, golang, etc. etc.

# git
alias get="git"
alias g="git"
alias gadd="git add ."
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias sourcetree='open -a SourceTree'

# golang
export GLOBALGOPATH=$HOME/Projects/golang
export GOPATH=$GLOBALGOPATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin # Add GOPATH/bin to PATH for scripting

alias gob='go build'
alias goc='go clean'
alias god='go doc'
alias gof='go fmt'
alias gofa='go fmt . ./...'
alias gog='go get'
alias goi='go install'
alias gol='go list'
alias gor='go run'
alias got='go test'
alias gov='go vet'

resetgopath() {
	export GOPATH=$GLOBALGOPATH
	echo $GOPATH
}

setgopath() {
	export GOPATH="$(pwd)"
	echo $GOPATH
}

goinit() {
	appname="${1:-mynewapp}"
	gitpath="${2:-github.com/mattmc3}"
	mkdir -p "$appname/pkg" "$appname/bin" "$appname/src/$gitpath/$appname"
	export GOPATH="$(pwd)/$appname"
	echo $GOPATH
	$VISUAL "$GOPATH/src/$gitpath/$appname"
}

# groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec  # per homebrew
export GROOVY_TURN_OFF_JAVA_WARNINGS="true"

# java
if [[ "$OSTYPE" == darwin* ]]; then
	# run this: /usr/libexec/java_home -v 10
	export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home"

	# alias j12="export JAVA_HOME=\`/usr/libexec/java_home -v 12\`; java -version"
	# alias j11="export JAVA_HOME=\`/usr/libexec/java_home -v 11\`; java -version"
	# alias j10="export JAVA_HOME=\`/usr/libexec/java_home -v 10\`; java -version"
fi

# jupyter
alias juno="jupyter notebook"

# jupyter can use the BROWSER variable
#export BROWSER=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
#export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox

# lpass
export LPASS_AGENT_TIMEOUT=0

# macos specific
if [[ "$OSTYPE" == darwin* ]]; then
	export HOMEBREW_CASK_OPTS="--appdir=/Applications"

	alias lmk="say 'Process complete.'"
	alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
	alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

	alias bcu="brew cu"
	alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to clipboard.'"

	# Recursively clean files
	alias cleands="find . -name '.DS_Store' -depth -exec rm {} \;"

	# Canonical hex dump; some systems have this symlinked
	command -v hd > /dev/null || alias hd="hexdump -C"

	# macOS has no 'md5sum', so use 'md5' as a fallback
	command -v md5sum > /dev/null || alias md5sum="md5"

	# macOS has no 'sha1sum', so use 'shasum' as a fallback
	command -v sha1sum > /dev/null || alias sha1sum="shasum"

	# images {{{
	# auto-orient images based on exif tags
	alias autorotate="jhead -autorot"

	# mogrify -resize 20% image.jpg  # make image 20% of its original size
	# }}}
fi

# mono
if [[ "$OSTYPE" == darwin* ]]; then
	# per homebrew
	export MONO_GAC_PREFIX="/usr/local"
fi

# python
export WORKON_HOME=~/.virtualenvs

alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

workon() {
	source "$WORKON_HOME/$1/bin/activate"
}

pyclean() {
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete
}

if [[ -n $ZSH_VERSION ]]; then
	# python: tab complete for workon dir (virtualenv)
	compdef '_files -W "$WORKON_HOME"' workon &> /dev/null
fi

# ssh
if [[ -f ~/.ssh/id_rsa ]] && ! ssh-add -L >/dev/null; then
	if [[ "$OSTYPE" == darwin* ]]; then
		# TODO: review b/c this is a (small) hit performance-wise
		# macos uses keychain with ssh -K
		ssh-add -K ~/.ssh/id_rsa &> /dev/null
	else
		ssh-add ~/.ssh/id_rsa &> /dev/null
	fi
fi

# tmux -------------------------------------------------------------------------
# re-home app configs to ~/.config
# tmux sucks at modern and uses -f instead of knowing about XDG
export TMUX_HOME="$XDG_CONFIG_HOME"/tmux/tmux.conf && _ensure "$TMUX_HOME"
alias tmux='tmux -f "$TMUX_HOME"'

# todo.txt ---------------------------------------------------------------------
export TODOTXT_CFG_FILE="$XDG_CONFIG_HOME"/todotxt/config
export TODO="t"
alias t="todo.sh"
alias todo="subl ~/Dropbox/notes/todo/todo.txt"

# z
export _Z_DATA="${XDG_DATA_HOME}/z/z"
# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		echo -e "${1}${branchName}${2}${s}";
	else
		return;
	fi;
}

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]"; # working directory base name
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\] at ";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\w"; # working directory full path
PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]"; # '$' (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;
# completions for bash... s...l...o...w...
# [[ -f /usr/local/etc/bash_completion ]] && . /usr/local/etc/bash_completion
