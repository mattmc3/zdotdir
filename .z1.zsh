#!/bin/zsh
# .z1
# > Z-One: A powerful starter kit for Zsh in a single file
# Project Home: https://github.com/mattmc3/z-one

# Init z1
() {
  typeset -g Z1_VERSION="0.0.1"
  typeset -gaH __z1_opts=(extended_glob NO_xtrace NO_ksh_arrays)

  # Add variables for key Zsh directories.
  export __zsh_config_dir=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}
  export __zsh_user_data_dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh
  export __zsh_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh

  # Ensure Zsh directories exist.
  local zdir
  for zdir in __zsh_{config,user_data,cache}_dir; do
    [[ -d "${(P)zdir}" ]] || mkdir -p ${(P)zdir}
  done

  # Customize with zstyles.
  [[ ! -r $__zsh_config_dir/.zstyles ]] || source $__zsh_config_dir/.zstyles
}

##? run_compinit - Initialize the built-in Zsh completion system.
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

# compstyle_z1_setup - Set Zsh completion styles.
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

# __memoize_cmd - Evaluate a command, cache its output, and use its cache for 20 hours
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

# prompt_z1_setup - Add a nice prompt for Z1 users.
function prompt_z1_setup {
  emulate -L zsh; setopt local_options $__z1_opts

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

    # Set vcs_info parameters.
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '%F{green}•%f'
    zstyle ':vcs_info:*' unstagedstr '%F{yellow}•%f'
    zstyle ':vcs_info:*' formats '%b%c%u%m'
    zstyle ':vcs_info:*' actionformats "%b%c%u%m|%F{cyan}%a%f"
    zstyle ':vcs_info:git*+set-message:*' hooks git_status

    # Define prompts.
    PROMPT='$_prompt_z1_pwd ❱ '
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

# colormap - Print a quick colormap
function colormap {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
  done
}

# Run z1.
() {
  #
  # Options
  #

  local zshopts=(
    # https://zsh.sourceforge.io/Doc/Release/Options.html
    # 16.2.1 Changing Directories
    auto_pushd              # Make cd push the old directory onto the dirstack.
    pushd_minus             # Exchanges meanings of +/- when navigating the dirstack.
    pushd_silent            # Do not print the directory stack after pushd or popd.
    pushd_to_home           # Push to home directory when no argument is given.

    # 16.2.2 Completion
    always_to_end           # Move cursor to the end of a completed word.
    auto_list               # Automatically list choices on ambiguous completion.
    auto_menu               # Show completion menu on a successive tab press.
    auto_param_slash        # If completed parameter is a directory, add a trailing slash.
    complete_in_word        # Complete from both ends of a word.
    path_dirs               # Perform path search even on command names with slashes.
    NO_flow_control         # Disable start/stop characters in shell editor.
    NO_menu_complete        # Do not autoselect the first completion entry.

    # 16.2.3 Expansion and Globbing
    extended_glob           # Use extended globbing syntax.
    glob_dots               # Don't hide dotfiles from glob patterns.

    # 16.2.4 History
    bang_hist               # Treat the '!' character specially during expansion.
    extended_history        # Write the history file in the ':start:elapsed;command' format.
    hist_expire_dups_first  # Expire a duplicate event first when trimming history.
    hist_find_no_dups       # When using find, only display a command once.
    hist_ignore_dups        # Do not record an event that was just recorded again.
    hist_ignore_space       # Do not record an event starting with a space.
    hist_verify             # Do not execute immediately upon history expansion.
    inc_append_history      # Write to the history file immediately, not when the shell exits.
    NO_share_history        # Do not share history between all sessions.
    NO_hist_beep            # Do not beep when accessing non-existent history.

    # 16.2.6 Input/Output
    interactive_comments    # Enable comments in interactive shell.
    rc_quotes               # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
    NO_clobber              # Don't overwrite files with >. Use >| to bypass.
    NO_mail_warning         # Don't print a warning if a mail file was accessed.
    NO_rm_star_silent       # Ask for confirmation for `rm *' or `rm path/*'

    # 16.2.7 Job Control
    auto_resume             # Attempt to resume existing job before creating a new process.
    long_list_jobs          # List jobs in the long format by default.
    notify                  # Report status of background jobs immediately.
    NO_bg_nice              # Don't run all background jobs at a lower priority.
    NO_check_jobs           # Don't report on jobs when shell exit.
    NO_hup                  # Don't kill jobs on shell exit.

    # 16.2.8 Prompting
    prompt_subst            # Expand parameters in prompt variables

    # 16.2.9 Scripts and Functions
    multios                 # Write to multiple descriptors.

    # 16.2.12 Zle
    combining_chars         # Combine 0-len chars with base chars (eg: accents).
    NO_beep                 # Be quiet
  )
  setopt $zshopts

  #
  # Autoload functions
  #

  # Add autoload functions directory.
  typeset -g ZFUNCDIR
  zstyle -s ':z1:function' dir 'ZFUNCDIR' \
    || ZFUNCDIR=$__zsh_config_dir/functions
  local fndir
  for fndir in $ZFUNCDIR(-/FN) $ZFUNCDIR/*(-/FN); do
    fpath=($fndir $fpath)
    autoload -Uz $fndir/*~*/_*(N.:t)
  done

  #
  # Colorize
  #

  # Built-in zsh colors
  autoload -Uz colors && colors

  # Show man pages in color.
  export LESS_TERMCAP_mb=$'\e[01;34m'      # mb:=start blink-mode (bold,blue)
  export LESS_TERMCAP_md=$'\e[01;34m'      # md:=start bold-mode (bold,blue)
  export LESS_TERMCAP_so=$'\e[00;47;30m'   # so:=start standout-mode (white bg, black fg)
  export LESS_TERMCAP_us=$'\e[04;35m'      # us:=start underline-mode (underline magenta)
  export LESS_TERMCAP_se=$'\e[0m'          # se:=end standout-mode
  export LESS_TERMCAP_ue=$'\e[0m'          # ue:=end underline-mode
  export LESS_TERMCAP_me=$'\e[0m'          # me:=end modes

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

  #
  # Directory
  #

  # Show directory stack.
  alias dirh='dirs -v'

  #
  # History
  #

  # Set the path to the history file.
  zstyle -s ':z1:history' histfile 'HISTFILE' \
    || HISTFILE="$__zsh_user_data_dir/zsh_history"
  # Set the maximum number of events to save in the internal history.
  zstyle -s ':z1:history' histsize 'HISTSIZE' \
    || HISTSIZE=20000
  # Set the maximum number of events to save in the history file.
  zstyle -s ':z1:history' savehist 'SAVEHIST' \
    || SAVEHIST=100000

  # Use a better history command.
  alias history='fc -li'

  #
  # Utilities
  #

  # Use built-in paste magic.
  autoload -Uz bracketed-paste-url-magic
  zle -N bracketed-paste bracketed-paste-url-magic
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic

  # Load more specific 'run-help' function from $fpath.
  (( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
  alias help=run-help

  # Allow mapping Ctrl+S and Ctrl+Q shortcuts
  [[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]] && stty -ixon <$TTY >$TTY

  #
  # Completions
  #

  # Add custom completions directory.
  fpath=($__zsh_config_dir/completions(/N) $fpath)

  # Set completion zstyles.
  typeset -g ZSH_COMPSTYLE
  zstyle -s ':z1:completion' compstyle 'ZSH_COMPSTYLE' \
    || ZSH_COMPSTYLE=z1
  (( $+functions[compstyle_${ZSH_COMPSTYLE}_setup] )) && compstyle_${ZSH_COMPSTYLE}_setup

  # Initialize completions if the user didn't.
  (( $+functions[compinit] )) || run_compinit

  #
  # Prompt
  #

  # Initialize prompt if the user didn't.
  if ! (( $+functions[promptinit] )); then
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
  fi
}

# vim: ft=zsh sw=2 ts=2 et
