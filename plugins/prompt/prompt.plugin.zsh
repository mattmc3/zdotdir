### prompt - Setup prompts

0=${(%):-%x}
setopt prompt_subst
fpath=(${0:A:h}/functions $fpath)
autoload -Uz $fpath[1]/*(.:t)
