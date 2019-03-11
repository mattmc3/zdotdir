#!/usr/bin/env bash
# generate a single bashrc

PROJ_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"
SHELLRCD="$PROJ_DIR/shellrc.d"

shopt -s nullglob
shopt -s extglob

echo "# generated via makefile\n" > "$PROJ_DIR"/_generated/.bashrc
cat "$SHELLRCD"/*.{sh,bash} >> "$PROJ_DIR"/_generated/.bashrc
