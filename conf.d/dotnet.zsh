# zsh parameter completion for the dotnet CLI
# https://learn.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete

path+=($HOME/.dotnet/tools(N))

_dotnet_zsh_complete() {
  local completions=("$(dotnet complete "$words")")

  if [[ -z "$completions" ]]; then
    _arguments '*::arguments: _normal'
    return
  fi

  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet
