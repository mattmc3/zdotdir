#
# editor: Setup Zsh line editor behavior.
#

# 16.2.6 Input/Output
setopt interactive_comments    # Enable comments in interactive shell.
setopt rc_quotes               # Allow 'Hitchhikers''s Guide' instead of 'Hitchhikers'\''s Guide'.
setopt NO_flow_control         # Disable start/stop characters (usually ^Q/^S) in shell editor.
setopt NO_mail_warning         # Don't print a warning message if a mail file has been accessed.

# 16.2.12 Zle
setopt combining_chars  # Combine 0-len chars with the base character (eg: accents).
setopt NO_beep          # Beep on error in line editor.

# Treat these characters as part of a word.
[[ -n "$WORDCHARS" ]] || WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Use human-friendly identifiers.
zmodload zsh/terminfo

# Emacs keybindings
bindkey -e
