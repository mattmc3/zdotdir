#
# gpg - PGP encryption
#

export GNUPGHOME=${XDG_DATA_HOME:=~/.local/share}/gnupg
[[ -e $GNUPGHOME:h ]] || mkdir -p $GNUPGHOME:h
alias gpg="command gpg --homedir \"\$GNUPGHOME\""
