# Starship faster-than-light

zstyle ':zephyr:plugin:prompt' skip yes

# Load plugin functions.
0=${(%):-%N}
fpath=(${0:A:h}/functions $fpath)
autoload -Uz ${0:A:h}/functions/*(.:t)
