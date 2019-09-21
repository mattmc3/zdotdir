# zsh profiling
# just execute 'ZSH_PROFILE_RC=1 zsh' and run 'zprof' to get the details
if [[ $ZSH_PROFILE_RC -gt 0 ]] ; then
    zmodload zsh/zprof
    echo "run zprof to profile"
fi

# conf.d
for file in $ZDOTDIR/conf.d/*.{sh,zsh}(N); do
  case $file:t in ~*) continue;; esac
  source "$file"
done
unset file

# I dislike when my prompt starts with an error
true
