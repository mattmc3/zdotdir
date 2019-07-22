# ssh --------------------------------------------------------------------------
if [[ -f ~/.ssh/id_rsa ]] && ! ssh-add -L >/dev/null; then
  if [[ "$OSTYPE" == darwin* ]]; then
    # TODO: review b/c this is a (small) hit performance-wise
    # macos uses keychain with ssh -K
    ssh-add -K ~/.ssh/id_rsa &> /dev/null
  else
    ssh-add ~/.ssh/id_rsa &> /dev/null
  fi
fi
