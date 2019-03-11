# XDG
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory

# Make sure XDG dirs are set
[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME=$HOME/.config
[[ -n "$XDG_CACHE_HOME"  ]] || export XDG_CACHE_HOME=$HOME/.cache
[[ -n "$XDG_DATA_HOME"   ]] || export XDG_DATA_HOME=$HOME/.local/share
[[ -n "$XDG_RUNTIME_DIR" ]] || export XDG_RUNTIME_DIR=$HOME/.xdg

_ensure_file() {
	# ensure the file exists
	if [ -n "$1" ] && [ ! -f "$1" ]; then
		mkdir -p "${1%/*}" && touch "$1"
	fi
}

if [[ -n $ZSH_VERSION ]]; then
	SHELLNAME="zsh"
elif [[ -n $BASH_VERSION ]]; then
	SHELLNAME="bash"
fi

# re-home app data to ~/.local/share
HISTFILE="${XDG_DATA_HOME}/${SHELLNAME}/${SHELLNAME}_history"; _ensure_file "$HISTFILE"
export LESSHISTFILE="${XDG_DATA_HOME}/less/lesshst"; _ensure_file "$LESSHISTFILE"
