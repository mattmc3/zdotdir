#!/usr/bin/env zsh
PROJ_DIR="$( cd "$( dirname "${0:a}" )"/.. && pwd )"
PACKAGES_LIST="$PROJ_DIR"/shellrc.d/antibody_packages.txt
PACKAGES_FILE="$PROJ_DIR"/shellrc.d/40_plugins.zsh
antibody bundle < "$PACKAGES_LIST" > "$PACKAGES_FILE"
sed -i '' "s|$HOME|\$HOME|g" "$PACKAGES_FILE"
