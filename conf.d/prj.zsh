#
# prj: Project jumper
#

if [[ -e /opt/homebrew/bin/prj ]]; then
  eval "$(/opt/homebrew/bin/prj -i zsh)"
elif [[ -e $HOME/bin/prj ]]; then
  eval "$("$HOME/bin/prj" -i zsh)"
fi
