#!/bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
typeset -gU cdpath fpath path prepath  # ensure unique

# Prepath lets us always keep certain directories at the front. If something changes
# path, you can set `path=($prepath $path)` again at the end of .zshrc.
prepath=(
  ~/bin
  ~/.local/bin
)
path=($prepath $path)

# Path to your Oh My Zsh installation.
export ZSH="${ZDOTDIR:-$HOME}/.oh-my-zsh"
[ -d "$ZSH" ] || git clone --quiet https://github.com/ohmyzsh/ohmyzsh "$ZSH"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="romkatv/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
if [[ ! -d ${ZDOTDIR:-$HOME}/.zsh_custom ]]; then
  git clone git@github.com:mattmc3/zsh_custom ${ZDOTDIR:-$HOME}/.zsh_custom
fi
zsh_custom=(${ZDOTDIR:-$HOME}/.zsh_custom)

# Set completions variables
ZSH_DISABLE_COMPFIX=true
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${ZSH_COMPDUMP:h}"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
typeset -gU plugins
plugins=(
  # Essentials
  brew

  # Clipboard
  copypath
  copybuffer
  copyfile

  # Colors
  colored-man-pages

  # Utils
  direnv
  extract
  git
  gitignore
  macos
  magic-enter
  python
  zoxide

  # Zsh Custom
  mattmc3/zman
  # autoloader
  # wezterm
  # utility
  # zsh-bench

  # Core
  romkatv/zsh-no-ps2
  zsh-users/zsh-autosuggestions
  zdharma-continuum/fast-syntax-highlighting
  history-substring-search
)

##### START OMZ PLUS! ##################################################################
export OMZ_PLUS=${ZDOTDIR:-$HOME}/.omz-plus
[ -d "$OMZ_PLUS" ] || git clone git@github.com:mattmc3/omz-plus $OMZ_PLUS
source $OMZ_PLUS/omz-plus.sh
##### END OMZ PLUS! ####################################################################

[[ -r ${ZDOTDIR:-$HOME}/.zshrc.pre.local ]] && source ${ZDOTDIR:-$HOME}/.zshrc.pre.local
source $ZSH/oh-my-zsh.sh
[[ -r ${ZDOTDIR:-$HOME}/.zshrc.post.local ]] && source ${ZDOTDIR:-$HOME}/.zshrc.post.local

### User configuration

## Config magic-enter
# Set the default commands to run when none is given
MAGIC_ENTER_GIT_COMMAND='git status -sb'
MAGIC_ENTER_OTHER_COMMAND='ls'

## Config zsh-autosuggestions
# Set highlight color, default 'fg=8'.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Set key bindings.
if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi

# Set the list of directories that cd searches.
cdpath=(
  $HOME/Projects(N/)
  $HOME/Projects/jtb/(N/)
  $HOME/Projects/mattmc3/(N/)
  $cdpath
)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh
