#region HEADER
#
# completion: Set up system for Zsh completion styles similar to prompt system.
#

# References:
# - https://github.com/zsh-users/zsh/blob/master/Functions/Prompts/promptinit

0=${(%):-%N}
zstyle -t ':zephyr:lib:bootstrap'    loaded || source ${0:a:h:h:h}/lib/bootstrap.zsh
zstyle -t ':zephyr:plugin:compstyle' loaded && return 1
#endregion

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1
! zstyle -t ":zephyr:plugin:compstyle" skip || return 0

function compstyle_zephyr_help {
  echo "A composite of the grml, prezto, and ohmyzsh completions."
  echo "You can invoke it with the following command:"
  echo
  echo "  compstyle zephyr"
  echo
  echo "More information available at: https://github.com/mattmc3/zephyr"
}

function compstyle_zephyr_setup {
  # Pre-reqs.
  : ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
  [[ -d $__zsh_cache_dir ]] || mkdir -p $__zsh_cache_dir

  # Standard style used by default for 'list-colors'
  LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}

  # Defaults.
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*:default' list-prompt '%S%M matches%s'

  # Use caching to make completion for commands such as dpkg and apt usable.
  zstyle ':completion::complete:*' use-cache on
  zstyle ':completion::complete:*' cache-path "$__zsh_cache_dir/zcompcache"

  # Case-insensitive (all), partial-word, and then substring completion.
  if zstyle -t ':zephyr:plugin:compstyle:*' case-sensitive; then
    zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
    setopt case_glob
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
    unsetopt case_glob
  fi

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

  # Populate hostname completion. But allow ignoring custom entries from static
  # */etc/hosts* which might be uninteresting.
  zstyle -a ':zephyr:plugin:compstyle:*:hosts' etc-host-ignores '_etc_host_ignores'

  zstyle -e ':completion:*:hosts' hosts 'reply=(
    ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
    ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
    ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
  )'

  # Don't complete uninteresting users...
  zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
    dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
    hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
    mailman mailnull mldonkey mysql nagios \
    named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
    operator pcap postfix postgres privoxy pulse pvm quagga radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

  # ... unless we really want to.
  zstyle '*' single-ignored show

  # Ignore multiple entries.
  zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
  zstyle ':completion:*:rm:*' file-patterns '*:all-files'

  # Kill
  zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:*:kill:*' force-list always
  zstyle ':completion:*:*:kill:*' insert-ids single

  # Man
  zstyle ':completion:*:manuals' separate-sections true
  zstyle ':completion:*:manuals.(^1*)' insert-sections true
  zstyle ':completion:*:man:*' menu yes select

  # Media Players
  zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
  zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
  zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
  zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

  # Mutt
  if [[ -s "$HOME/.mutt/aliases" ]]; then
    zstyle ':completion:*:*:mutt:*' menu yes select
    zstyle ':completion:*:mutt:*' users ${${${(f)"$(<"$HOME/.mutt/aliases")"}#alias[[:space:]]}%%[[:space:]]*}
  fi

  # SSH/SCP/RSYNC
  zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
  zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
  zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
  zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
  zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
  zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
}

# Load with `autoload -Uz compstyleinit; compstyleinit'.
# Type `compstyle -h' for help.
function compstyleinit {
  typeset -gaU completion_styles
  typeset -ga completion_style
  completion_styles=(zephyr)

  function compstyleinit {
    emulate -L zsh; setopt extendedglob

    local name setupfn
    local -a match

    # Autoload all compstyle_*_setup functions in fpath.
    for setupfn in $^fpath/compstyle_*_setup(N); do
      if [[ $setupfn == */compstyle_(#b)(*)_setup ]]; then
        name="$match[1]"
        if [[ -r "$setupfn" ]]; then
          completion_styles=($completion_styles $name)
          autoload -Uz compstyle_${name}_setup
        else
          print "Cannot read '$setupfn' file containing completion styles."
        fi
      else
        print "Unexpect compstyle setup function '$setupfn'."
      fi
    done
  }

  function _compstyle_usage {
    emulate -L zsh; setopt extended_glob
    local -a usage=(
      'Usage: compstyle [-l] [-h [<style>]]'
      '       compstyle <style>'
      'Options:'
      '  -l            List currently available completion styles'
      '  -h [<style>]  Display help (for given compstyle)'
      'Arguments:'
      '  <style>       Switch to new compstyle'
      ''
      'Use `compstyle -h` for help.'
      'Load with `autoload -Uz compstyleinit; compstyleinit`.'
      'Set completion style with `compstyle <compstyle>`.'
    )

    if [[ -n "$1" && -n "$completion_styles[(r)$1]" ]]; then
      # Run this in a subshell, so we don't need to clean up afterwards.
      (
        # If we can't find a _help function, run the _setup function to see
        # if it will create one.
        (( $+functions[compstyle_$1_help] )) || compstyle_$1_setup

        # ...then try again.
        if (( $+functions[compstyle_$1_help] )); then
          print "Help for '$1' completion style:\n"
          compstyle_$1_help
        else
          print "No help available for '$1' completion style."
        fi
      )
    else
      printf '%s\n' "${usage[@]}"
    fi
  }

  function compstyle {
    # compstyle [-l] [-h [<style>]]
    local opt
    while getopts 'lh' opt; do
      case "$opt" in
        l) print Currently available completion styles:
          print $completion_styles
          return
          ;;
        h) _compstyle_usage "$@[2,-1]"; return $? ;;
        *) _compstyle_usage;            return 2  ;;
      esac
    done

    # error if compstyle specified not found
    if [[ -z "$1" || -z $completion_styles[(r)$1] ]]; then
      print >&2 "compstyle: Completion style not found '$1'."
      _compstyle_usage
      return 1
    fi

    # TODO: cleanup any prior completion styles

    # set the new completion styles
    compstyle_$1_setup "$@[2,-1]" && completion_style=( "$@" )
  }

  compstyleinit "$@"
}

#region MARK LOADED
zstyle ':zephyr:plugin:compstyle' loaded 'yes'
#endregion
