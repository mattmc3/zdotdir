# Parsing Zsh options

## Manually

```zsh
# Manual opt parsing example
#
# Features:
# - supports short and long flags (ie: -v|--verbose)
# - supports short and long key/value options (ie: -f <file> | --filename <file>)
# - supports short and long key/value options with equals assignment (ie: -f=<file> | --filename=<file>)
# - does NOT support short option chaining (ie: -vh)
# - everything after -- is positional even if it looks like an option (ie: -f)
# - once we hit an arg that isn't an option flag, everything after that is considered positional
function optparsing_demo() {
  local positional=()
  local flag_verbose=false
  local filename=myfile

  local usage=(
    "optparsing_demo [-h|--help]"
    "optparsing_demo [-v|--verbose] [-f|--filename=<file>] [<message...>]"
  )
  opterr() { echo >&2 "optparsing_demo: Unknown option '$1'" }

  while (( $# )); do
    case $1 in
      --)                 shift; positional+=("$@"); break  ;;
      -h|--help)          printf "%s\n" $usage && return    ;;
      -v|--verbose)       flag_verbose=true                 ;;
      -f|--filename)      shift; filename=$1                ;;
      -f=*|--filename=*)  filename="${1#*=}"                ;;
      -*)                 opterr $1 && return 2             ;;
      *)                  positional+=("$@"); break         ;;
    esac
    shift
  done

  echo "--verbose: $flag_verbose"
  echo "--filename: $filename"
  echo "positional: $positional"
}
```

## With zparseopts

```zsh
# zparseopts
#
# Resources:
# - https://xpmo.gitlab.io/post/using-zparseopts/
# - https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#index-zparseopts
#
# Features:
# - supports short and long flags (ie: -v|--verbose)
# - supports short and long key/value options (ie: -f <file> | --filename <file>)
# - does NOT support short and long key/value options with equals assignment (ie: -f=<file> | --filename=<file>)
# - supports short option chaining (ie: -vh)
# - everything after -- is positional even if it looks like an option (ie: -f)
# - once we hit an arg that isn't an option flag, everything after that is considered positional
function zparseopts_demo() {
  local flag_help flag_verbose
  local arg_filename=(myfile)  # set a default
  local usage=(
    "zparseopts_demo [-h|--help]"
    "zparseopts_demo [-v|--verbose] [-f|--filename=<file>] [<message...>]"
  )

  # -D pulls parsed flags out of $@
  # -E allows flags/args and positionals to be mixed, which we don't want in this example
  # -F says fail if we find a flag that wasn't defined
  # -M allows us to map option aliases (ie: h=flag_help -help=h)
  # -K allows us to set default values without zparseopts overwriting them
  # Remember that the first dash is automatically handled, so long options are -opt, not --opt
  zmodload zsh/zutil
  zparseopts -D -F -K -- \
    {h,-help}=flag_help \
    {v,-verbose}=flag_verbose \
    {f,-filename}:=arg_filename ||
    return 1

  [[ -z "$flag_help" ]] || { print -l $usage && return }
  if (( $#flag_verbose )); then
    print "verbose mode"
  fi

  echo "--verbose: $flag_verbose"
  echo "--filename: $arg_filename[-1]"
  echo "positional: $@"
}
```

## Here are some examples of the manual parsing function in action...

Call with no args

```zsh
$ optparsing_demo
--verbose: false
--filename: myfile
positional:
```

Call with both short and long options, as well as positional args

```zsh
$ optparsing_demo --verbose -f test.txt foo
--verbose: true
--filename: test.txt
positional: foo
```

Call with -- to pass positionals that look like flags

```zsh
$ optparsing_demo --filename=test.txt -- -v --verbose -f --filename are acceptable options
--verbose: false
--filename: test.txt
positional: -v --verbose -f --filename are acceptable options
```

Called incorrectly with positionals before intended opts

```zsh
$ optparsing_demo do not put positionals before opts --verbose --filename=mynewfile
--verbose: false
--filename: myfile
positional: do not put positionals before opts --verbose --filename=mynewfile
```

This method of opt parsing does not support flag chaining like getopt does

```zsh
$ optparsing_demo -vh
optparsing_demo: Unknown option '-vh'
```

---

## Here are some examples of the zparseopt version in action...

Call with no args

```zsh
$ zparseopts_demo
--verbose:
--filename: myfile
positional:
```

Call with both short and long options, as well as positional args

```zsh
$ zparseopts_demo --verbose -f test.txt foo
--verbose: --verbose
--filename: test.txt
positional: foo
```

Call with -- to pass positionals that look like flags

```zsh
$ zparseopts_demo --filename test.txt -- -v --verbose -f --filename are acceptable options
--verbose:
--filename: test.txt
positional: -v --verbose -f --filename are acceptable options
```

Called incorrectly with positionals before intended opts. If you want this,
zparseopts supports it with the -E flag.

```zsh
$ zparseopts_demo do not put positionals before opts --verbose --filename=mynewfile
--verbose:
--filename: myfile
positional: do not put positionals before opts --verbose --filename=mynewfile
```

This method of opt parsing does supports flag chaining like getopt does

```zsh
$ zparseopts_demo -vh
zparseopts_demo [-h|--help]
zparseopts_demo [-v|--verbose] [-f|--filename=<file>] [<message...>]
```
