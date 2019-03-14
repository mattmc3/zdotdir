main() {
	for file in $ZDOTDIR/zshrc.d/*.{sh,zsh}(N); do
		case $file:t in ~*) continue;; esac
		source "$file"
	done

	[[ -f $ZDOTDIR/.zshrc.local ]] && . $ZDOTDIR/.zshrc.local
	return 0
}
main
