if [[ -z "$XDG_CONFIG_HOME" ]]; then
  export TODOTXT_CFG_FILE="$HOME"/.todo/config
else
  export TODOTXT_CFG_FILE="$XDG_CONFIG_HOME"/todo-txt/config
fi

alias t="todo.sh"
alias todos="$VISUAL $HOME/Desktop/todo.txt"
