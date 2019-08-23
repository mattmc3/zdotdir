#!/usr/bin/env zsh
PROJ_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"
ZSHD="$PROJ_DIR"/zsh/.config/zsh/zshrc.d
antibody bundle < "$ZSHD"/packages.txt > "$ZSHD"/030_antibody.zsh
sed -i '' "s|$HOME|\$HOME|g" "$ZSHD"/030_antibody.zsh
