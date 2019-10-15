### profiling -------------------------------------------------------------- {{{
# execute 'ZPROF_ENABLE=1 zsh' and run 'zprof' to get profiler details
alias zperf='ZPROF_ENABLE=1 zsh'
alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'
if [[ $ZPROF_ENABLE -gt 0 ]] ; then
  zmodload zsh/zprof
  echo 'now run `zprof` to profile...'
fi
### }}}

### completions ------------------------------------------------------------ {{{
# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L41
autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
unset _comp_files
### }}}

### plugins ---------------------------------------------------------------- {{{
# zgen is a pretty awesome and speedy plugin manager
export ZGEN_DIR="${ZDOTDIR:-$HOME}"/.zgen
[[ -d "$ZGEN_DIR" ]] || git clone https://github.com/tarjoilija/zgen.git --depth=1 "$ZGEN_DIR"
ZGEN_RESET_ON_CHANGE=(
  ${ZDOTDIR:-$HOME}/.zshrc
  ${ZDOTDIR:-$HOME}/zplugins
)
ZGEN_AUTOLOAD_COMPINIT=false
OMZ="$ZGEN_DIR/robbyrussell/oh-my-zsh-master"

# set for omz history plugin
HIST_STAMPS="yyyy-mm-dd"

# if plugins change ZGEN_RESET_ON_CHANGE should catch it, or run `zgen reset`
source "$ZGEN_DIR/zgen.zsh"
if ! zgen saved; then
  # clone things we don't need to load directly
  zgen clone robbyrussell/oh-my-zsh

  # omz lib - sourced this way for speed
  zgen load $OMZ/lib/clipboard.zsh
  zgen load $OMZ/lib/functions.zsh
  zgen load $OMZ/lib/history.zsh
  zgen load $OMZ/lib/key-bindings.zsh
  zgen load $OMZ/lib/termsupport.zsh

  # omz plugins
  zgen load $OMZ/plugins/colored-man-pages
  zgen load $OMZ/plugins/history

  # regular plugins from github
  zgen load mafredri/zsh-async
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-history-substring-search
  zgen load mattmc3/zsh-safe-rm
  zgen load mattmc3/zsh-cd-ls
  zgen load rummik/zsh-tailf
  zgen load peterhurford/up.zsh
  zgen load rupa/z

  # theme
  # zgen load denysdovhan/spaceship-prompt
  # zgen load sindresorhus/pure
  zgen load miekg/lean

  # use zplugins file for other plugins if it exists
  if [[ -f $ZDOTDIR/zplugins ]]; then
    zgen loadall < $ZDOTDIR/zplugins
  fi

  # plugins that should come last!
  zgen load zdharma/fast-syntax-highlighting

  # save zgen plugins into init.zsh
  zgen save
fi
### }}}

### zfunctions ------------------------------------------------------------- {{{
if [[ -z $ZFUNCTIONS_DIR ]]; then
  ZFUNCTIONS_DIR="${ZDOTDIR:-$HOME}/zfunctions"
fi
[[ -d "$ZFUNCTIONS_DIR" ]] || mkdir -p "$ZFUNCTIONS_DIR"
fpath=("$ZFUNCTIONS_DIR" $fpath);
autoload -U "$ZFUNCTIONS_DIR"/*(.:t)
### }}}

### zshrc.d ---------------------------------------------------------------- {{{
# zshrc.d lets you extend the contents of this file
for _zfile in $ZDOTDIR/zshrc.d/*.{sh,zsh}(N); do
  # ignore files that begin with a tilde
  case $_zfile:t in ~*) continue;; esac
  # source the file
  . "$_zfile"
done
unset _zfile
### }}}

### local ------------------------------------------------------------------ {{{
# .zshrc.local lets you add overrides that are machine specific
# keep this file out of git!
[[ -f "${ZDOTDIR:-HOME}"/.zshrc.local ]] && . "${ZDOTDIR:-HOME}"/.zshrc.local
### }}}

### done ------------------------------------------------------------------- {{{
# let's start the shell prompt on a good note (no errors)
return true
### }}}
