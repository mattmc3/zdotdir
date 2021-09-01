git checkout main 2> /dev/null
if [[ $? -ne 0 ]]; then
  git checkout master
fi
