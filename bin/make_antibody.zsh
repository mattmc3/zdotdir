#!/usr/bin/env zsh
antibody bundle < "$ZDOTDIR/plugins/antibody_plugins.txt" > "$ZDOTDIR/plugins/antibody_plugins.zsh"
sed -i '' "s|$HOME|\$HOME|g" "$ZDOTDIR/plugins/antibody_plugins.zsh"
