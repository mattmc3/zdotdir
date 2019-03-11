PROJ_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
for file in "$PROJ_DIR"/shellrc.d/*+(.sh|.bash); do
	case "$(basename $file)" in ~*) continue;; esac
	source "$file"
done
