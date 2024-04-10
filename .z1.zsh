#!/bin/zsh
# > Z1: A powerful Zsh config in a single file
# Project Home: https://github.com/mattmc3/z1
# License: MIT

# Init z1
() {
  typeset -g Z1_VERSION="0.0.1"
  typeset -gaH __z1_opts=(extended_glob NO_monitor NO_xtrace NO_ksh_arrays)

  # Add variables for key Zsh directories.
  export __zsh_config_dir=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}
  export __zsh_user_data_dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh
  export __zsh_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh

  # Ensure Zsh directories exist.
  local zdir
  for zdir in __zsh_{config,user_data,cache}_dir; do
    [[ -d "${(P)zdir}" ]] || mkdir -p ${(P)zdir}
  done

  # Define Z1 paths
  typeset -g Z1_{COMPLETIONS,CONFIGS,FUNCTION,REPO}_DIR
  typeset -g Z1_{COMPSTYLE,THEME}

  # Directory for Zsh autoload functions.
  zstyle -s ':z1:functions' dir 'Z1_FUNCTION_DIR' \
    || Z1_FUNCTION_DIR=${Z1_FUNCTION_DIR:-$__zsh_config_dir/functions}

  # Directory for cloned Zsh plugin repos.
  zstyle -s ':z1:repos' dir 'Z1_REPO_DIR' \
    || Z1_REPO_DIR=${Z1_REPO_DIR:-$__zsh_cache_dir/repos}

  # Customize with zstyles.
  [[ ! -r $__zsh_config_dir/.zstyles ]] || source $__zsh_config_dir/.zstyles
}

# z1_colorize: Add color to your terminal.
function z1_colorize {
  # Built-in zsh colors
  autoload -Uz colors && colors

  # colormap: Print a quick colormap.
  function colormap {
    for i in {0..255}; do
      print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
  }

  # Show man pages in color.
  export LESS_TERMCAP_mb=$'\e[01;34m'      # mb:=start blink-mode (bold,blue)
  export LESS_TERMCAP_md=$'\e[01;34m'      # md:=start bold-mode (bold,blue)
  export LESS_TERMCAP_so=$'\e[00;47;30m'   # so:=start standout-mode (white bg, black fg)
  export LESS_TERMCAP_us=$'\e[04;35m'      # us:=start underline-mode (underline magenta)
  export LESS_TERMCAP_se=$'\e[0m'          # se:=end standout-mode
  export LESS_TERMCAP_ue=$'\e[0m'          # ue:=end underline-mode
  export LESS_TERMCAP_me=$'\e[0m'          # me:=end modes

  # __memoize_cmd: Evaluate a command, cache its output, and use its cache for 20 hours.
  function __memoize_cmd {
    emulate -L zsh; setopt local_options $__z1_opts
    local memofile=$__zsh_cache_dir/memoized/$1; shift
    local -a cached=($memofile(Nmh-20))
    if ! (( $#cached )); then
      mkdir -p ${memofile:h}
      "$@" >| $memofile
    fi
    source $memofile
  }

  # Set colors for grep and ls command using dircolors if available.
  alias grep="${aliases[grep]:-grep} --color=auto"
  if (( $+commands[gdircolors] )); then
    __memoize_cmd 'gdircolors.zsh' gdircolors --sh
    alias gls="${aliases[gls]:-gls} --group-directories-first --color=auto"
  fi
  if (( $+commands[dircolors] )); then
    __memoize_cmd 'dircolors.zsh' dircolors --sh
    alias ls="${aliases[ls]:-ls} --group-directories-first --color=auto"
  else
    alias ls="${aliases[ls]:-ls} -G"
    export LSCOLORS=${LSCOLORS:-exfxcxdxbxGxDxabagacad}
  fi
}

# z1_confd: Source Zsh config files in a conf.d directory.
function z1_confd {
  local confd zfile
  zstyle -s ':z1:configs' dir 'confd' || confd=$__zsh_config_dir/conf.d
  for zfile in $confd/*.zsh(N); do
    [[ ${zfile:t} != '~'* ]] || continue
    source $zfile
  done
}

# z1_completions: Setup Zsh completion system.
function z1_completions {
  # Set options related to the completions.
  setopt always_to_end     # Move cursor to the end of a completed word.
  setopt auto_list         # Automatically list choices on ambiguous completion.
  setopt auto_menu         # Show completion menu on a successive tab press.
  setopt auto_param_slash  # If completed param is a directory, add trailing slash.
  setopt complete_in_word  # Complete from both ends of a word.
  setopt path_dirs         # Perform path search even on command names with slashes.
  setopt NO_flow_control   # Disable start/stop characters in shell editor.
  setopt NO_menu_complete  # Do not autoselect the first completion entry.

  # Add custom completions directory.
  local compdir
  zstyle -s ':z1:completions' dir 'compdir' || compdir=$__zsh_config_dir/completions
  fpath=($compdir(/N) $fpath)

  # Set completion zstyles.
  local compstyle
  zstyle -s ':z1:completion' compstyle 'compstyle' || compstyle=z1
  (( $+functions[compstyle_${compstyle}_setup] )) && compstyle_${compstyle}_setup

  # Initialize completions if the user didn't.
  (( $+functions[compinit] )) || run_compinit
}

# z1_directory: Set options and aliases for file system.
function z1_directory {
  # Set options related to the file system, globbing, and directory stack.
  setopt auto_pushd     # Make cd push the old directory onto the dirstack.
  setopt pushd_minus    # Exchange meaning of +/- when navigating the dirstack.
  setopt pushd_silent   # Do not print the directory stack after pushd or popd.
  setopt pushd_to_home  # Push to home directory when no argument is given.
  setopt extended_glob  # Use extended globbing syntax.
  setopt glob_dots      # Don't hide dotfiles from glob patterns.
  setopt multios        # Write to multiple descriptors.
  setopt NO_clobber     # Don't overwrite files with >. Use >| to bypass.

  # Show directory stack.
  alias dirh='dirs -v'
}

# z1_editor: Setup editor and keybinds.
function z1_editor {
  # Allow mapping Ctrl+S and Ctrl+Q shortcuts
  [[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]] && stty -ixon <$TTY >$TTY

  # No PS2
  builtin zle -N z1_editor_no_ps2
  bindkey '^J' z1_editor_no_ps2
  bindkey '^M' z1_editor_no_ps2
  bindkey -e
}

# z1_history: Set options, variables, and aliases for Zsh history.
function z1_history {
  setopt bang_hist               # Treat the '!' character specially during expansion.
  setopt extended_history        # Write the history file in the ':start:elapsed;command' format.
  setopt hist_expire_dups_first  # Expire a duplicate event first when trimming history.
  setopt hist_find_no_dups       # When using find, only display a command once.
  setopt hist_ignore_dups        # Do not record an event that was just recorded again.
  setopt hist_ignore_space       # Do not record an event starting with a space.
  setopt hist_verify             # Do not execute immediately upon history expansion.
  setopt inc_append_history      # Write to the history file immediately, not when the shell exits.
  setopt NO_share_history        # Do not share history between all sessions.
  setopt NO_hist_beep            # Do not beep when accessing non-existent history.

  # Set the path to the history file.
  zstyle -s ':z1:history' histfile 'HISTFILE' || HISTFILE="$__zsh_user_data_dir/zsh_history"
  # Set the maximum number of events to save in the internal history.
  zstyle -s ':z1:history' histsize 'HISTSIZE' || HISTSIZE=20000
  # Set the maximum number of events to save in the history file.
  zstyle -s ':z1:history' savehist 'SAVEHIST' || SAVEHIST=100000

  # Use a better history command.
  alias history='fc -li'
}

# z1_funcdir: Setup the autoload directory for Zsh functions.
function z1_funcdir {
  emulate -L zsh; setopt local_options $__z1_opts
  local fndir zfuncdir
  zstyle -s ':z1:functions' dir 'zfuncdir' || zfuncdir=$__zsh_config_dir/functions
  for fndir in $zfuncdir(-/FN) $zfuncdir/*(-/FN); do
    fpath=($fndir $fpath)
    autoload -Uz $fndir/*~*/_*(N.:t)
  done
}

# z1_plugins: Setup Zsh plugins.
function z1_plugins {
  emulate -L zsh; setopt local_options $__z1_opts

  local repo_dir giturl
  zstyle -s ':z1:repos' repo_dir 'repo_dir' || repo_dir=$__zsh_cache_dir/repos
  zstyle -s ':z1:plugins' git_url  'git_url'  || git_url="https://github.com"

  # Get all the different plugin types.
  local -a {clone,path,fpath,zsh,defer}_plugins
  zstyle -a ':z1:plugins:load:kind' clone 'clone_plugins'
  zstyle -a ':z1:plugins:load:kind' path  'path_plugins'
  zstyle -a ':z1:plugins:load:kind' fpath 'fpath_plugins'
  zstyle -a ':z1:plugins:load:kind' zsh   'zsh_plugins'
  zstyle -a ':z1:plugins:load:kind' defer 'defer_plugins'

  # Combine for cloning missing ones.
  local -a plugins=($clone_plugins $path_plugins $fpath_plugins $zsh_plugins $defer_plugins)

  # Remove bare words ${(M)plugins:#*/*} and paths with leading slash ${plugins:#/*}.
  # Then split/join to keep the 2-part user/repo form to bulk-clone repos.
  local repo; local -aU repos
  for repo in ${${(M)plugins:#*/*}:#/*}; do
    repo=${(@j:/:)${(@s:/:)repo}[1,2]}
    if [[ ! -d $ZSH_REPO_HOME/$repo ]]; then
      (
        command git clone -q --depth 1 --recursive --shallow-submodules \
          $git_url/$repo $ZSH_REPO_HOME/$repo
          plugin-compile $ZSH_REPO_HOME/$repo
      ) &
    fi
  done
  wait
}

# z1_prompt: Setup built-in Zsh prompt system.
function z1_prompt {
  # Set prompt options.
  setopt prompt_subst  # Expand parameters in prompt variables

  # Initialize built-in prompt system.
  autoload -Uz promptinit && promptinit

  # Since we define prompt functions here and not in autoload function files in $fpath,
  # we need to stick the theme's name into `$prompt_themes' ourselves, since promptinit
  # does not pick them up otherwise.
  prompt_themes+=( z1 )
  # Also, keep the array sorted...
  prompt_themes=( "${(@on)prompt_themes}" )

  # Set prompt.
  local -a prompt_argv
  zstyle -a ':z1:prompt' theme 'prompt_argv'
  if [[ $TERM == (dumb|linux|*bsd*) ]]; then
    prompt 'off'
  elif (( $#prompt_argv > 0 )); then
    prompt "$prompt_argv[@]"
  fi
}

# z1_utility: Set Zsh utilities and options.
function z1_utility {
  # 16.2.6 Input/Output
  setopt interactive_comments    # Enable comments in interactive shell.
  setopt rc_quotes               # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
  setopt NO_mail_warning         # Don't print a warning if a mail file was accessed.
  setopt NO_rm_star_silent       # Ask for confirmation for `rm *' or `rm path/*'

  # 16.2.7 Job Control
  setopt auto_resume             # Attempt to resume existing job before creating a new process.
  setopt long_list_jobs          # List jobs in the long format by default.
  setopt notify                  # Report status of background jobs immediately.
  setopt NO_bg_nice              # Don't run all background jobs at a lower priority.
  setopt NO_check_jobs           # Don't report on jobs when shell exit.
  setopt NO_hup                  # Don't kill jobs on shell exit.

  # 16.2.12 Zle
  setopt combining_chars         # Combine 0-len chars with base chars (eg: accents).
  setopt NO_beep                 # Be quiet

  # Use built-in paste magic.
  autoload -Uz bracketed-paste-url-magic
  zle -N bracketed-paste bracketed-paste-url-magic
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic

  # Load more specific 'run-help' function from $fpath.
  (( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
  alias help=run-help
}

# run_compinit: Initialize the built-in Zsh completion system.
function run_compinit {
  emulate -L zsh; setopt local_options $__z1_opts

  # Zsh compdump file.
  typeset -g ZSH_COMPDUMP
  zstyle -s ':z1:completion' compdump 'ZSH_COMPDUMP' ||
    ZSH_COMPDUMP=$__zsh_cache_dir/zcompdump

  # Load and initialize the completion system ignoring insecure directories with a
  # cache time of 20 hours, so it should almost always regenerate the first time a
  # shell is opened each day.
  autoload -Uz compinit
  local comp_files=($ZSH_COMPDUMP(Nmh-20))
  if (( $#comp_files )); then
    compinit -i -C -d "$ZSH_COMPDUMP"
  else
    compinit -i -d "$ZSH_COMPDUMP"
    # Ensure $ZSH_COMPDUMP is younger than the cache time even if it isn't regenerated.
    touch "$ZSH_COMPDUMP"
  fi

  # Compile zcompdump, if modified, in background to increase startup speed.
  {
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
      if command mkdir "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null; then
        zcompile "$ZSH_COMPDUMP"
        command rmdir  "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null
      fi
    fi
  } &!
}

# compstyle_z1_setup: Set Zsh completion styles.
function compstyle_z1_setup {
  emulate -L zsh; setopt local_options $__z1_opts

  # Defaults.
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*:default' list-prompt '%S%M matches%s'

  # Case-insensitive (all), partial-word, and then substring completion.
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

  # Group matches and describe.
  zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*:matches' group 'yes'
  zstyle ':completion:*:options' description 'yes'
  zstyle ':completion:*:options' auto-description '%d'
  zstyle ':completion:*:corrections' format ' %F{red}-- %d (errors: %e) --%f'
  zstyle ':completion:*:descriptions' format ' %F{purple}-- %d --%f'
  zstyle ':completion:*:messages' format ' %F{green} -- %d --%f'
  zstyle ':completion:*:warnings' format ' %F{yellow}-- no matches found --%f'
  zstyle ':completion:*' format ' %F{blue}-- %d --%f'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' verbose yes

  # Fuzzy match mistyped completions.
  zstyle ':completion:*' completer _complete _match _approximate
  zstyle ':completion:*:match:*' original only
  zstyle ':completion:*:approximate:*' max-errors 1 numeric

  # Increase the number of errors based on the length of the typed word. But make
  # sure to cap (at 7) the max-errors to avoid hanging.
  zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

  # Don't complete unavailable commands.
  zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

  # Array completion element sorting.
  zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

  # Directories
  zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
  zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
  zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
  zstyle ':completion:*' squeeze-slashes true
  zstyle ':completion:*' special-dirs ..

  # History
  zstyle ':completion:*:history-words' stop yes
  zstyle ':completion:*:history-words' remove-all-dups yes
  zstyle ':completion:*:history-words' list false
  zstyle ':completion:*:history-words' menu yes

  # Environment Variables
  zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

  # Ignore multiple entries.
  zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
  zstyle ':completion:*:rm:*' file-patterns '*:all-files'

  # Kill
  zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:*:kill:*' force-list always
  zstyle ':completion:*:*:kill:*' insert-ids single

  # complete manual by their section
  zstyle ':completion:*:manuals'    separate-sections true
  zstyle ':completion:*:manuals.*'  insert-sections   true
  zstyle ':completion:*:man:*'      menu yes select
}

# prompt_z1_setup: Add a nice prompt for Z1 users.
function prompt_z1_setup {
  # Remove right prompt from prior commands
  setopt transient_rprompt

  function prompt_pwd {
    setopt local_options extended_glob

    local cur_pwd="${PWD/#$HOME/~}"
    local MATCH result

    if [[ "$cur_pwd" == (#m)[/~] ]]; then
      result="$MATCH"
    elif zstyle -m ':z1:prompt' pwd-length 'full'; then
      result=${PWD}
    elif zstyle -m ':z1:prompt' pwd-length 'long'; then
      result=${cur_pwd}
    else
      result="${${${${(@j:/:M)${(@s:/:)cur_pwd}##.#?}:h}%/}//\%/%%}/${${cur_pwd:t}//\%/%%}"
    fi

    print -r -- "$result"
  }

  function +vi-git_status {
    # Check for untracked files or updated submodules since vcs_info does not.
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
      hook_com[unstaged]='%F{red}•%f'
    fi

    ### git: Show ⇡N/⇣N when your local branch is ahead-of or behind remote HEAD.
    # Make sure you have added misc to your 'formats':  %m
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
      $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( "⇡${ahead}" )
    (( $behind )) && gitstatus+=( "⇣${behind}" )

    hook_com[misc]+=${(j:/:)gitstatus}
  }

  function prompt_z1_precmd {
    setopt local_options
    unsetopt xtrace ksh_arrays
    _prompt_z1_pwd=$(prompt_pwd)
    vcs_info
  }

  function prompt_z1_setup {
    setopt local_options
    unsetopt xtrace ksh_arrays
    prompt_opts=(cr percent sp subst)

    # Load required functions.
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    # Add hook for calling vcs_info before each command.
    add-zsh-hook precmd prompt_z1_precmd

    # Define default prompt colors.
    typeset -gA _prompt_z1_colors=(
      black   "000"
      red     "001"
      green   "002"
      yellow  "003"
      blue    "004"
      magenta "005"
      cyan    "006"
      white   "007"
    )

    # Use extended color pallete if available.
    if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
      zstyle -s ':z1:prompt:colors' black   '_prompt_z1_colors[black]'   || _prompt_z1_colors[black]="000"
      zstyle -s ':z1:prompt:colors' red     '_prompt_z1_colors[red]'     || _prompt_z1_colors[red]="160"
      zstyle -s ':z1:prompt:colors' green   '_prompt_z1_colors[green]'   || _prompt_z1_colors[green]="076"
      zstyle -s ':z1:prompt:colors' yellow  '_prompt_z1_colors[yellow]'  || _prompt_z1_colors[yellow]="178"
      zstyle -s ':z1:prompt:colors' blue    '_prompt_z1_colors[blue]'    || _prompt_z1_colors[blue]="039"
      zstyle -s ':z1:prompt:colors' magenta '_prompt_z1_colors[magenta]' || _prompt_z1_colors[magenta]="168"
      zstyle -s ':z1:prompt:colors' cyan    '_prompt_z1_colors[cyan]'    || _prompt_z1_colors[cyan]="037"
      zstyle -s ':z1:prompt:colors' white   '_prompt_z1_colors[white]'   || _prompt_z1_colors[white]="255"
    fi

    # Define default prompt symbols.
    typeset -gA _prompt_z1_chars=(
      success "%%"
      error   "%%"
      vicmd   "V"
      stash   "="
      dirty   "*"
      ahead   "+"
      behind  "-"
    )

    # Use unicode chars if available.
    if ! zstyle -t ':z1:prompt:unicode' disable; then
      zstyle -s ':z1:prompt:character' success '_prompt_z1_chars[success]' || _prompt_z1_chars[success]="❱"
      zstyle -s ':z1:prompt:character' error   '_prompt_z1_chars[error]'   || _prompt_z1_chars[error]="❱"
      zstyle -s ':z1:prompt:character' vicmd   '_prompt_z1_chars[vicmd]'   || _prompt_z1_chars[vicmd]="❰"
      zstyle -s ':z1:prompt:character' stash   '_prompt_z1_chars[stash]'   || _prompt_z1_chars[stash]="☰"
      zstyle -s ':z1:prompt:character' dirty   '_prompt_z1_chars[dirty]'   || _prompt_z1_chars[dirty]="•"  # "✱"
      zstyle -s ':z1:prompt:character' ahead   '_prompt_z1_chars[ahead]'   || _prompt_z1_chars[ahead]="⇡"
      zstyle -s ':z1:prompt:character' behind  '_prompt_z1_chars[behind]'  || _prompt_z1_chars[behind]="⇣"
    fi

    # Set vcs_info parameters.
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr "%F{${_prompt_z1_colors[green]}}${_prompt_z1_chars[dirty]}%f"
    zstyle ':vcs_info:*' unstagedstr "%F{${_prompt_z1_colors[yellow]}}${_prompt_z1_chars[dirty]}%f"
    zstyle ':vcs_info:*' formats '%b%c%u%m'
    zstyle ':vcs_info:*' actionformats "%b%c%u%m|%F{cyan}%a%f"
    zstyle ':vcs_info:git*+set-message:*' hooks git_status

    # Define prompts.
    PROMPT='%F{${_prompt_z1_colors[blue]}}$_prompt_z1_pwd%f %F{${_prompt_z1_colors[green]}}$_prompt_z1_chars[success]%f '
    RPROMPT='${vcs_info_msg_0_}'
  }

  function prompt_z1_preview {
    local +h PROMPT=''
    local +h RPROMPT=''
    local +h SPROMPT=''

    editor-info 2> /dev/null
    prompt_preview_theme 'z1'
  }

  prompt_z1_setup "$@"
}

function z1_editor_no_ps2 {
  emulate -L zsh
  local -r func=no-ps2-test

  if (( ${+functions[$func]} )); then
    unfunction -- $func
  fi

  if functions[$func]=$PREBUFFER$BUFFER 2>/dev/null &&
    (( ${+functions[$func]} )); then
    unfunction -- $func
    if functions[$func]=$PREBUFFER$BUFFER$'\ndo\ndone' 2>/dev/null &&
      (( ${+functions[$func]} )) ; then
      unfunction -- $func
    else
      local w
      zstyle -s 'z1:editor:no-ps2:' accept-line w || w=accept-line
      if [[ -n $w ]]; then
        builtin zle -- $w
      fi
      return
    fi
  fi

  LBUFFER+=$'\n'
}

# plugin-clone: Use git to clone Zsh plugins in parallel.
function plugin-clone {
  emulate -L zsh; setopt local_options $__z1_opts

  local repo_dir git_url
  zstyle -s ':z1:plugins:repos' dir     'repo_dir' || repo_dir=$__zsh_cache_dir/repos
  zstyle -s ':z1:plugins:repos' git_url 'git_url'  || git_url="https://github.com"

  local repo repo_url plugin_dir
  local -Ua repos=($@)
  for repo in $repos; do
    if [[ $repo == (http(|s)://|git@)* ]]; then
      repo_url=$repo
    else
      repo_url=$git_url/$repo
    fi

    plugin_dir=$repo_dir/${${repo_url:t}%.git}
    if [[ ! -d $plugin_dir ]]; then
      echo "Cloning $repo..."
      (
        command git clone --quiet --depth 1 --recursive --shallow-submodules $repo_url $plugin_dir
        plugin-compile $plugin_dir
      ) &
    fi
  done
  wait
}

# plugin-home: Show the plugin home directory
function plugin-home {
  emulate -L zsh; setopt local_options $__z1_opts
  local repo_dir
  zstyle -s ':z1:plugins:repos' dir 'repo_dir' || repo_dir=$__zsh_cache_dir/repos
  print -r -- $repo_dir
}

# plugin-list: List cloned plugins.
function plugin-list {
  emulate -L zsh; setopt local_options $__z1_opts
  local repo_dir plugin_dir
  zstyle -s ':z1:plugins:repos' dir 'repo_dir' || repo_dir=$__zsh_cache_dir/repos
  for plugin_dir in $repo_dir/*/.git(N/); do
    print -r -- ${plugin_dir:A:h:t}
  done
}

# plugin-update: Use git to pull updates to Zsh plugins.
function plugin-update {
  emulate -L zsh; setopt local_options $__z1_opts
  local repo_dir
  zstyle -s ':z1:plugins:repos' dir 'repo_dir' || repo_dir=$__zsh_cache_dir/repos

  local plugin_dir oldsha newsha
  for plugin_dir in $repo_dir/*/.git(N/); do
    plugin_dir=${plugin_dir:A:h}
    echo "Updating ${plugin_dir:t}..."
    (
      oldsha=$(command git -C $plugin_dir rev-parse --short HEAD)
      command git -C $plugin_dir pull --quiet --ff --depth 1 --rebase --autostash
      newsha=$(command git -C $plugin_dir rev-parse --short HEAD)
      [[ $oldsha == $newsha ]] || echo "Plugin updated: $plugin_dir:t ($oldsha -> $newsha)"
    ) &
  done
  wait
  plugin-compile
  echo "Update complete."
}

# plugin-compile: Compile plugins.
function plugin-compile {
  emulate -L zsh; setopt local_options $__z1_opts
  local repo_dir
  zstyle -s ':z1:plugins:repos' dir 'repo_dir' || repo_dir=$__zsh_cache_dir/repos
  autoload -Uz zrecompile
  local zfile
  for zfile in ${1:-$repo_dir}/**/*.zsh{,-theme}(N); do
    [[ $zfile != */test-data/* ]] || continue
    zrecompile -pq "$zfile"
  done
}

# Run z1.
() {
  z1_funcdir
  z1_colorize
  z1_directory
  z1_editor
  z1_history
  z1_utility
  z1_plugins
  z1_confd
  z1_completions
  z1_prompt
}

# vim: ft=zsh sw=2 ts=2 et
