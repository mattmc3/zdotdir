#
# utility - misc
#

(( $+commands[envsubst] )) || function envsubst {
  python -c 'import os,sys;[sys.stdout.write(os.path.expandvars(l)) for l in sys.stdin]'
}
