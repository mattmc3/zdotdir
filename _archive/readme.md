# Reference

Sometimes I forget what I'm searching for when I need help with Z Shell. This
is a place for notes and stuff.

## Docs

- [filename-generation][filename-generation] for when you don't remember...
- [zsh-glob-qualifiers][zsh-glob-qualifiers] glob qualifiers/suffixes:
  - `(-.N)`:
    - dash (-): toggles between making the qualifiers work on symbolic links (the default) and the files they point to
    - dot (.): plain files
    - N: NULL_GLOB
  - `*.zsh{,-theme}(.NLk+1)`:
    - Lk+1: files over 1k

[filename-generation]:  http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation
[zsh-glob-qualifiers]:  http://zsh.sourceforge.net/Doc/Release/Expansion.html#Glob-Qualifiers
