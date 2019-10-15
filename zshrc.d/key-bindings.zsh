### key-bindings ----------------------------------------------------------- {{{
# zsh doesn't use .inputrc, so this file holds keybindings
# https://github.com/changs/slimzsh/blob/master/keys.zsh
# http://zsh.sourceforge.net/Doc/Release/Parameters.html

# use the default OMZ key-bindings
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/key-bindings.zsh
# [[ -f $ZSH/lib/key-bindings.zsh ]] && . $ZSH/lib/key-bindings.zsh

# add our own bindings not in OMZ
export KEYTIMEOUT=1  # remove lag

bindkey -s '\el' "ls\n"
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[^[[C' emacs-forward-word
bindkey '^[^[[D' emacs-backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
bindkey "^F" forward-word
bindkey "^B" backward-word
bindkey '^[[Z' reverse-menu-complete
