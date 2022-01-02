function read_plugins_file {
  #cat $ZDOTDIR foo.txt
  typeset -a lines=("${(f)"$(<zsh_plugins)"}")
  print ${#lines}
  for l in $lines; do
    if [[ $l == \#* ]]; then
      echo "--comment--: $l"
    else
      echo "-- line --: $l"
    fi
  done
}
