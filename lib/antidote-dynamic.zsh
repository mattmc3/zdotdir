# Create an amazing Zsh config using antidote plugins.
if [[ ! -d $ZDOTDIR/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote $ZDOTDIR/.antidote
fi
source $ZDOTDIR/.antidote/antidote.zsh

# Pins
OMZ_SHA=7ea697fd8138550ddf7262456d412f0dcd1cbf84 # 2026-07-29

source <(antidote init)
antidote bundle "mattmc3/starship-ftl post:'ftl-prompt starship zsh; ftl-transient on'"
antidote bundle <<EOBUNDLES
  # Better Zsh defaults
  mattmc3/z1
  mattmc3/use-xdg-basedirs

  # Utils
  mattmc3/zman
  using:mattmc3/zephyr path:plugins
  macos

  # OMZ plugins
  using:ohmyzsh/ohmyzsh path:plugins pin:$OMZ_SHA
  magic-enter
  fancy-ctrl-z
  extract

  # romkatv/powerlevel10k
  romkatv/zsh-bench kind:path
  romkatv/zsh-no-ps2

  # Fish-like
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions kind:fpath path:src
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-history-substring-search post:bindkey-hss
EOBUNDLES
