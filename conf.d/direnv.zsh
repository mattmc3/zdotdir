# If direnv is not found, don't continue and print a warning
if (( ! $+commands[direnv] )); then
  print -ru2 "Warning: direnv not found. Please install direnv and ensure it's in your PATH before using this plugin."
  return 1
fi

if (( $+functions[cached-eval] )); then
  cached-eval direnv hook zsh
else
  source <(direnv hook zsh)
fi
