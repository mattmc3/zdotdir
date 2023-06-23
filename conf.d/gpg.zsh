#
# gpg
#

export GNUPGHOME=${XDG_DATA_HOME:=~/.local/share}/gnupg
alias gpg="command gpg --homedir \"\$GNUPGHOME\""
