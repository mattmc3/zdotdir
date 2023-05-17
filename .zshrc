#
# .zshrc - Run on interactive Zsh session.
#

[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# zsh options
setopt transient_rprompt

# vars
repos=(
  # themes
  mbadolato/iTerm2-Color-Schemes

  # utilities
  romkatv/zsh-bench

  # prompts
  sindresorhus/pure
  romkatv/powerlevel10k
)

myplugins=(
  git
  python
  mattmc3/zman
  rupa/z
  zsh-users/zsh-completions
  ohmyzsh/ohmyzsh/lib/clipboard.zsh
  ohmyzsh/ohmyzsh/plugins/copybuffer
  ohmyzsh/ohmyzsh/plugins/magic-enter
  ohmyzsh/ohmyzsh/plugins/fancy-ctrl-z
  zshzoo/editor
  zshzoo/macos
  zshzoo/terminal

  # deferred
  romkatv/zsh-defer
  olets/zsh-abbr
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
)

# zstyles
zstyle ':zebrafish:prompt' theme 'starship'
zstyle ':zebrafish:plugins' clone $repos
zstyle ':zebrafish:plugins' load $myplugins

# Zebrafish
source $ZDOTDIR/.zebrafish

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC

# [[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
# alias zprofrc="ZPROFRC=1 zsh"

# # Load aliases.
# [[ -f $ZDOTDIR/.zaliases ]] && . $ZDOTDIR/.zaliases

# # Essential zsh options
# setopt extended_glob no_beep

# # Lazy-load functions directory like fish.
# for fndir in $ZDOTDIR/functions(/FN) $ZDOTDIR/functions/*(/FN); do
#   fpath=($fndir $fpath)
#   autoload -Uz $fndir/*~*/_*(N.:t)
# done

# # Add custom completions directory like fish.
# fpath=($ZDOTDIR/completions(/N) $fpath)

# # external repos
# REPOS=${XDG_CACHE_HOME:=~/.cache}/repos
# [[ -d $REPOS ]] || repo in <$ZDOTDIR/repos.txt

# # zstyles
# zstyle ':zephyr:*:*' color 'yes'
# zstyle ':zephyr:plugin:history' histfile ${XDG_DATA_HOME:=~/.local/share}/zsh/zsh_history

# # editor
# zstyle ':zephyr:plugin:editor' key-bindings 'emacs'
# zstyle ':zephyr:plugin:editor' dot-expansion 'yes'
# zstyle :zle:edit-command-line editor hx

# # plugin configs
# ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/.zabbr
# MAGIC_ENTER_GIT_COMMAND='git status -sb'
# MAGIC_ENTER_OTHER_COMMAND='ls'
# ZSH_COMPDUMP=${XDG_CACHE_HOME:=~/.cache}/zephyr/zcompdump
# _Z_DATA=$XDG_DATA_HOME/z/data
# [[ -d $_Z_DATA:h ]] || mkdir -p $_Z_DATA:h

# # Plugin dirs
# OMZ=$REPOS/ohmyzsh/ohmyzsh/plugins
# ZEPHYR=$REPOS/mattmc3/zephyr/plugins
# MY=$ZDOTDIR/plugins

# source $REPOS/sorin-ionescu/prezto/runcoms/zprofile

# function zsh-defer {
#   "$@"
# }

# typeset -a plugins=(
#   $ZEPHYR/prompt
#   $ZEPHYR/utility
#   $ZEPHYR/clipboard
#   $ZEPHYR/terminal
#   $OMZ/magic-enter
#   $OMZ/fancy-ctrl-z
#   $ZEPHYR/editor
#   $ZEPHYR/history
#   $ZEPHYR/directory
#   $ZEPHYR/environment
#   $ZEPHYR/homebrew
#   $ZEPHYR/macos
#   $REPOS/rupa/z
#   $MY/python
#   $MY/git
#   $ZEPHYR/completion

#   # defers
#   $REPOS/romkatv/zsh-defer
#   $REPOS/mattmc3/zman
#   $REPOS/olets/zsh-abbr
#   $REPOS/zsh-users/zsh-autosuggestions
#   $REPOS/zsh-users/zsh-history-substring-search
#   $REPOS/zdharma-continuum/fast-syntax-highlighting
# )
# for plugin in $plugins; do
#   zsh-defer source $plugin/${plugin:t}.plugin.zsh
# done

# # Set prompt
# #prompt zephyr

# # Final
# source $REPOS/sorin-ionescu/prezto/runcoms/zlogin
# path+=($REPOS/romakatv/zsh-bench)

# # Fix prezto settings
# setopt NO_beep NO_hist_beep prompt_subst

# # Load local overrides.
# [[ -f $ZDOTDIR/.zlocal ]] && . $ZDOTDIR/.zlocal

# # Cleanup
# unset plugin fndir REPOS MY OMZ

# # Done profiling.
# [[ -z "$ZPROFRC" ]] || zprof
# unset ZPROFRC

# vim: ft=zsh sw=2 ts=2 et
