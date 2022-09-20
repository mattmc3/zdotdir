#
# Options
#

setopt AUTO_CD              # auto changes to a directory without typing cd
setopt AUTO_PUSHD           # push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS    # do not store duplicates in the stack
setopt PUSHD_SILENT         # do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME        # push to home directory when no argument is given
setopt CDABLE_VARS          # change directory to a path stored in a variable
setopt MULTIOS              # write to multiple descriptors
setopt EXTENDED_GLOB        # use extended globbing syntax
setopt GLOB_DOTS            # include dotfiles when globbing
unsetopt CLOBBER            # do not overwrite existing files with > and >>
                            # use >! and >>! to bypass

#
# Aliases
#

alias dirh='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index
