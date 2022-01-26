#!/usr/bin/env zsh
#
# plugin
# A simple antibody replacement: https://getantibody.github.io/
# plugin bundle < ${ZDOTDIR:-~}/.zsh_plugins.txt >| ${ZDOTDIR:-~}/.zsh_plugins.zsh
#

ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME}/.zplugins}

function _plugin-compile() {
  local repo plugin f
  autoload -U zrecompile
  for repo in $ZPLUGINDIR/*/.git/..(/); do
    plugin=${repo:A}
    for f in "$plugin"/**/*.zwc(N) "$plugin"/**/*.zwc.old(N); do
      command rm -f "$f"
    done
    for f in "$plugin"/**/*.zsh{,-theme}(N); do
      zrecompile -pq "$f"
    done
  done
}

function _plugin-update() {
  local repo plugin
  for repo in $ZPLUGINDIR/*/.git/..(/); do
    plugin=${repo:A}
    () {
      echo "Updating ${plugin:t}"
      for f in "$plugin"/**/*.zwc(N) "$plugin"/**/*.zwc.old(N); do
        command rm -f "$f"
      done
      command git -C "$plugin" pull --quiet --depth 1 --recurse-submodules --rebase --autostash
      echo "Done updating ${plugin:t}"
    } &
  done
  wait
}

function __plugin_clone() {
  local repo=$1
  local giturl=$repo
  local branch=$2
  local plugin=$ZPLUGINDIR/${repo:t}
  if [[ ! -d $plugin ]]; then
    [[ -z "$branch" ]] || branch="--branch=$branch"
    if [[ $repo != git://* &&
          $repo != https://* &&
          $repo != http://* &&
          $repo != ssh://* &&
          $repo != git@*:*/* ]]
    then
      giturl=https://github.com/$repo
    fi
    command git clone $branch --quiet --depth 1 --recurse-submodules --shallow-submodules $giturl $plugin
  fi
}

function __plugin_initfile() {
  local plugin_dir=$1
  local plugin_name=${plugin_dir:t}
  local initfiles
  initfiles=(
    $plugin_dir/$plugin_name.plugin.zsh(N)
    $plugin_dir/$plugin_name.zsh(N)
    $plugin_dir/init.zsh(N)
    $plugin_dir/*.plugin.{z,}sh(N)
    $plugin_dir/*.{z,}sh{-theme,}(N)
  )
  if [[ ${#initfiles[@]} -eq 0 ]]; then
    echo >&2 "No init file found '$1'." && return 1
  fi
  local f
  for f in $plugin_dir/init.zsh $plugin_dir/$plugin_name.plugin.zsh; do
    [[ -e $f ]] || ln -s $initfiles[1] $f
  done
}

function _plugin-bundle() {
  # if stdin containts no data, there's nothing to do
  [[ ! -t 0 ]] || return 1

  local zsh_plugins=()
  typeset -A repos
  local data parts repo instructions plugin branch subpath

  # handle both <redirected or piped| input
  # we need to loop twice - once to find all the git repos and clone them, and a second
  # time to bundle
  while read -r data; do
    # skip comments
    [[ $data != \#* ]] && [[ -n $data ]] || continue
    zsh_plugins+=($data)

    # split plugin from further instructions into array using space delimiter
    parts=(${(@s/ /)data})
    plugin=$parts[1]
    instructions=(${parts[@]:1})

    # if the plugin begins with a /, we assume it's on the file system and not a repo
    # for repos, we may need to clone before we can do other things
    if [[ $plugin != \/* ]]; then
      branch=$instructions[(r)branch:*]
      branch="${branch#*branch:}"
      # clone in background if we didn't already cloned the repo this session
      # remember, the same plugin can have multiple instructions
      # (ie: ohmyzsh/ohmyzsh path:lib/clipboard.zsh)
      if [[ -z "$repos[$plugin]" ]]; then
        repos[$plugin]=true
        () { __plugin_clone $plugin $branch; } &
      fi
    fi
  done

  # wait for clones to finish
  wait

  # bundle loop
  for data in $zsh_plugins; do
    # split plugin from further instructions into array using space delimiter
    parts=(${(@s/ /)data})
    plugin=$parts[1]
    instructions=(${parts[@]:1})

    # if kind:clone then we're done
    (( ! $instructions[(Ie)kind:clone] )) || continue

    # turn repos into plugin dirs
    if [[ $plugin != \/* ]]; then
      plugin=$ZPLUGINDIR/${plugin:t}
    fi

    # if 'path:*' instruction specified, we need a subdir or subfile of the plugin
    subpath=$instructions[(r)path:*]
    subpath="${subpath#*path:}"
    if [[ -n $subpath ]]; then
      plugin=$plugin/$subpath
    fi

    # if the plugin is just a file, source it and move to the next one
    if [[ -f $plugin ]]; then
      echo "source $plugin" && continue
    fi

    if [[ ! -d $plugin ]]; then
      echo "# ERROR: plugin directory not found $plugin" && continue
    fi

    if (( $instructions[(Ie)kind:fpath] )); then
      echo "fpath+=( $plugin )"
    elif (( $instructions[(Ie)kind:path] )); then
      echo "export PATH=\"$plugin:\$PATH\""
    else
      __plugin_initfile $plugin &>/dev/null
      [[ $? -eq 0 ]] || { echo "# ERROR: plugin init file not found '$plugin'." && continue }
      echo "fpath+=( $plugin )"
      echo "source $plugin/${plugin:t}.plugin.zsh"
    fi
  done
}

function _plugin() {
  local cmd=$1
  if (( $+functions[_plugin-${cmd}] )); then
    shift
    _plugin-${cmd} "$@"
    return $?
  else
    echo >&2 "The plugin command doesn't exist: '$1'."
    return 1
  fi
}
_plugin $@
