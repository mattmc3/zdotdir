#compdef starship

autoload -U is-at-least

_starship() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_starship_commands" \
"*::: :->starship" \
&& ret=0
    case $state in
    (starship)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:starship-command-$line[1]:"
        case $line[1] in
            (bug-report)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(completions)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
':shell:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(config)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
'::name -- Configuration key to edit:' \
'::value -- Value to place into that key:' \
&& ret=0
;;
(explain)
_arguments "${_arguments_options[@]}" : \
'-s+[The status code of the previously run command as an unsigned or signed 32bit integer]:STATUS_CODE: ' \
'--status=[The status code of the previously run command as an unsigned or signed 32bit integer]:STATUS_CODE: ' \
'*--pipestatus=[Bash, Fish and Zsh support returning codes for each process in a pipeline]:PIPESTATUS: ' \
'-w+[The width of the current interactive terminal]:TERMINAL_WIDTH: ' \
'--terminal-width=[The width of the current interactive terminal]:TERMINAL_WIDTH: ' \
'-p+[The path that the prompt should render for]:PATH:_files' \
'--path=[The path that the prompt should render for]:PATH:_files' \
'-P+[The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument]:LOGICAL_PATH:_files' \
'--logical-path=[The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument]:LOGICAL_PATH:_files' \
'-d+[The execution duration of the last command, in milliseconds]:CMD_DURATION: ' \
'--cmd-duration=[The execution duration of the last command, in milliseconds]:CMD_DURATION: ' \
'-k+[The keymap of fish/zsh/cmd]:KEYMAP: ' \
'--keymap=[The keymap of fish/zsh/cmd]:KEYMAP: ' \
'-j+[The number of currently running jobs]:JOBS: ' \
'--jobs=[The number of currently running jobs]:JOBS: ' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" : \
'--print-full-init[]' \
'-h[Print help]' \
'--help[Print help]' \
':shell:' \
&& ret=0
;;
(module)
_arguments "${_arguments_options[@]}" : \
'-s+[The status code of the previously run command as an unsigned or signed 32bit integer]:STATUS_CODE: ' \
'--status=[The status code of the previously run command as an unsigned or signed 32bit integer]:STATUS_CODE: ' \
'*--pipestatus=[Bash, Fish and Zsh support returning codes for each process in a pipeline]:PIPESTATUS: ' \
'-w+[The width of the current interactive terminal]:TERMINAL_WIDTH: ' \
'--terminal-width=[The width of the current interactive terminal]:TERMINAL_WIDTH: ' \
'-p+[The path that the prompt should render for]:PATH:_files' \
'--path=[The path that the prompt should render for]:PATH:_files' \
'-P+[The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument]:LOGICAL_PATH:_files' \
'--logical-path=[The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument]:LOGICAL_PATH:_files' \
'-d+[The execution duration of the last command, in milliseconds]:CMD_DURATION: ' \
'--cmd-duration=[The execution duration of the last command, in milliseconds]:CMD_DURATION: ' \
'-k+[The keymap of fish/zsh/cmd]:KEYMAP: ' \
'--keymap=[The keymap of fish/zsh/cmd]:KEYMAP: ' \
'-j+[The number of currently running jobs]:JOBS: ' \
'--jobs=[The number of currently running jobs]:JOBS: ' \
'-l[List out all supported modules]' \
'--list[List out all supported modules]' \
'-h[Print help]' \
'--help[Print help]' \
'::name -- The name of the module to be printed:' \
&& ret=0
;;
(preset)
_arguments "${_arguments_options[@]}" : \
'(-l --list)-o+[Output the preset to a file instead of stdout]:OUTPUT:_files' \
'(-l --list)--output=[Output the preset to a file instead of stdout]:OUTPUT:_files' \
'-l[List out all preset names]' \
'--list[List out all preset names]' \
'-h[Print help]' \
'--help[Print help]' \
'::name -- The name of preset to be printed:(bracketed-segments gruvbox-rainbow jetpack nerd-font-symbols no-empty-icons no-nerd-font no-runtime-versions pastel-powerline plain-text-symbols pure-preset tokyo-night)' \
&& ret=0
;;
(print-config)
_arguments "${_arguments_options[@]}" : \
'-d[Print the default instead of the computed config]' \
'--default[Print the default instead of the computed config]' \
'-h[Print help]' \
'--help[Print help]' \
'*::name -- Configuration keys to print:' \
&& ret=0
;;
(prompt)
_arguments "${_arguments_options[@]}" : \
'(--right)--profile=[Print the prompt with the specified profile name (instead of the standard left prompt)]:PROFILE: ' \
'-s+[The status code of the previously run command as an unsigned or signed 32bit integer]:STATUS_CODE: ' \
'--status=[The status code of the previously run command as an unsigned or signed 32bit integer]:STATUS_CODE: ' \
'*--pipestatus=[Bash, Fish and Zsh support returning codes for each process in a pipeline]:PIPESTATUS: ' \
'-w+[The width of the current interactive terminal]:TERMINAL_WIDTH: ' \
'--terminal-width=[The width of the current interactive terminal]:TERMINAL_WIDTH: ' \
'-p+[The path that the prompt should render for]:PATH:_files' \
'--path=[The path that the prompt should render for]:PATH:_files' \
'-P+[The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument]:LOGICAL_PATH:_files' \
'--logical-path=[The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument]:LOGICAL_PATH:_files' \
'-d+[The execution duration of the last command, in milliseconds]:CMD_DURATION: ' \
'--cmd-duration=[The execution duration of the last command, in milliseconds]:CMD_DURATION: ' \
'-k+[The keymap of fish/zsh/cmd]:KEYMAP: ' \
'--keymap=[The keymap of fish/zsh/cmd]:KEYMAP: ' \
'-j+[The number of currently running jobs]:JOBS: ' \
'--jobs=[The number of currently running jobs]:JOBS: ' \
'--right[Print the right prompt (instead of the standard left prompt)]' \
'(--right --profile)--continuation[Print the continuation prompt (instead of the standard left prompt)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(session)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(time)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(timings)
_arguments "${_arguments_options[@]}" : \
'-s+[The status code of the previously run command as an unsigned or signed 32bit integer]:STATUS_CODE: ' \
'--status=[The status code of the previously run command as an unsigned or signed 32bit integer]:STATUS_CODE: ' \
'*--pipestatus=[Bash, Fish and Zsh support returning codes for each process in a pipeline]:PIPESTATUS: ' \
'-w+[The width of the current interactive terminal]:TERMINAL_WIDTH: ' \
'--terminal-width=[The width of the current interactive terminal]:TERMINAL_WIDTH: ' \
'-p+[The path that the prompt should render for]:PATH:_files' \
'--path=[The path that the prompt should render for]:PATH:_files' \
'-P+[The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument]:LOGICAL_PATH:_files' \
'--logical-path=[The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument]:LOGICAL_PATH:_files' \
'-d+[The execution duration of the last command, in milliseconds]:CMD_DURATION: ' \
'--cmd-duration=[The execution duration of the last command, in milliseconds]:CMD_DURATION: ' \
'-k+[The keymap of fish/zsh/cmd]:KEYMAP: ' \
'--keymap=[The keymap of fish/zsh/cmd]:KEYMAP: ' \
'-j+[The number of currently running jobs]:JOBS: ' \
'--jobs=[The number of currently running jobs]:JOBS: ' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(toggle)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
':name -- The name of the module to be toggled:' \
'::value -- The key of the config to be toggled:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_starship__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:starship-help-command-$line[1]:"
        case $line[1] in
            (bug-report)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(completions)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(config)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(explain)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(module)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(preset)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(print-config)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(prompt)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(session)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(time)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(timings)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(toggle)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_starship_commands] )) ||
_starship_commands() {
    local commands; commands=(
'bug-report:Create a pre-populated GitHub issue with information about your configuration' \
'completions:Generate starship shell completions for your shell to stdout' \
'config:Edit the starship configuration' \
'explain:Explains the currently showing modules' \
'init:Prints the shell function used to execute starship' \
'module:Prints a specific prompt module' \
'preset:Prints a preset config' \
'print-config:Prints the computed starship configuration' \
'prompt:Prints the full starship prompt' \
'session:Generate random session key' \
'time:Prints time in milliseconds' \
'timings:Prints timings of all active modules' \
'toggle:Toggle a given starship module' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'starship commands' commands "$@"
}
(( $+functions[_starship__bug-report_commands] )) ||
_starship__bug-report_commands() {
    local commands; commands=()
    _describe -t commands 'starship bug-report commands' commands "$@"
}
(( $+functions[_starship__completions_commands] )) ||
_starship__completions_commands() {
    local commands; commands=()
    _describe -t commands 'starship completions commands' commands "$@"
}
(( $+functions[_starship__config_commands] )) ||
_starship__config_commands() {
    local commands; commands=()
    _describe -t commands 'starship config commands' commands "$@"
}
(( $+functions[_starship__explain_commands] )) ||
_starship__explain_commands() {
    local commands; commands=()
    _describe -t commands 'starship explain commands' commands "$@"
}
(( $+functions[_starship__help_commands] )) ||
_starship__help_commands() {
    local commands; commands=(
'bug-report:Create a pre-populated GitHub issue with information about your configuration' \
'completions:Generate starship shell completions for your shell to stdout' \
'config:Edit the starship configuration' \
'explain:Explains the currently showing modules' \
'init:Prints the shell function used to execute starship' \
'module:Prints a specific prompt module' \
'preset:Prints a preset config' \
'print-config:Prints the computed starship configuration' \
'prompt:Prints the full starship prompt' \
'session:Generate random session key' \
'time:Prints time in milliseconds' \
'timings:Prints timings of all active modules' \
'toggle:Toggle a given starship module' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'starship help commands' commands "$@"
}
(( $+functions[_starship__help__bug-report_commands] )) ||
_starship__help__bug-report_commands() {
    local commands; commands=()
    _describe -t commands 'starship help bug-report commands' commands "$@"
}
(( $+functions[_starship__help__completions_commands] )) ||
_starship__help__completions_commands() {
    local commands; commands=()
    _describe -t commands 'starship help completions commands' commands "$@"
}
(( $+functions[_starship__help__config_commands] )) ||
_starship__help__config_commands() {
    local commands; commands=()
    _describe -t commands 'starship help config commands' commands "$@"
}
(( $+functions[_starship__help__explain_commands] )) ||
_starship__help__explain_commands() {
    local commands; commands=()
    _describe -t commands 'starship help explain commands' commands "$@"
}
(( $+functions[_starship__help__help_commands] )) ||
_starship__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'starship help help commands' commands "$@"
}
(( $+functions[_starship__help__init_commands] )) ||
_starship__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'starship help init commands' commands "$@"
}
(( $+functions[_starship__help__module_commands] )) ||
_starship__help__module_commands() {
    local commands; commands=()
    _describe -t commands 'starship help module commands' commands "$@"
}
(( $+functions[_starship__help__preset_commands] )) ||
_starship__help__preset_commands() {
    local commands; commands=()
    _describe -t commands 'starship help preset commands' commands "$@"
}
(( $+functions[_starship__help__print-config_commands] )) ||
_starship__help__print-config_commands() {
    local commands; commands=()
    _describe -t commands 'starship help print-config commands' commands "$@"
}
(( $+functions[_starship__help__prompt_commands] )) ||
_starship__help__prompt_commands() {
    local commands; commands=()
    _describe -t commands 'starship help prompt commands' commands "$@"
}
(( $+functions[_starship__help__session_commands] )) ||
_starship__help__session_commands() {
    local commands; commands=()
    _describe -t commands 'starship help session commands' commands "$@"
}
(( $+functions[_starship__help__time_commands] )) ||
_starship__help__time_commands() {
    local commands; commands=()
    _describe -t commands 'starship help time commands' commands "$@"
}
(( $+functions[_starship__help__timings_commands] )) ||
_starship__help__timings_commands() {
    local commands; commands=()
    _describe -t commands 'starship help timings commands' commands "$@"
}
(( $+functions[_starship__help__toggle_commands] )) ||
_starship__help__toggle_commands() {
    local commands; commands=()
    _describe -t commands 'starship help toggle commands' commands "$@"
}
(( $+functions[_starship__init_commands] )) ||
_starship__init_commands() {
    local commands; commands=()
    _describe -t commands 'starship init commands' commands "$@"
}
(( $+functions[_starship__module_commands] )) ||
_starship__module_commands() {
    local commands; commands=()
    _describe -t commands 'starship module commands' commands "$@"
}
(( $+functions[_starship__preset_commands] )) ||
_starship__preset_commands() {
    local commands; commands=()
    _describe -t commands 'starship preset commands' commands "$@"
}
(( $+functions[_starship__print-config_commands] )) ||
_starship__print-config_commands() {
    local commands; commands=()
    _describe -t commands 'starship print-config commands' commands "$@"
}
(( $+functions[_starship__prompt_commands] )) ||
_starship__prompt_commands() {
    local commands; commands=()
    _describe -t commands 'starship prompt commands' commands "$@"
}
(( $+functions[_starship__session_commands] )) ||
_starship__session_commands() {
    local commands; commands=()
    _describe -t commands 'starship session commands' commands "$@"
}
(( $+functions[_starship__time_commands] )) ||
_starship__time_commands() {
    local commands; commands=()
    _describe -t commands 'starship time commands' commands "$@"
}
(( $+functions[_starship__timings_commands] )) ||
_starship__timings_commands() {
    local commands; commands=()
    _describe -t commands 'starship timings commands' commands "$@"
}
(( $+functions[_starship__toggle_commands] )) ||
_starship__toggle_commands() {
    local commands; commands=()
    _describe -t commands 'starship toggle commands' commands "$@"
}

if [ "$funcstack[1]" = "_starship" ]; then
    _starship "$@"
else
    compdef _starship starship
fi
