# ZSH reference

I can't always remember all the ZSH goodies, so here's all the wonderful stuff I have learned and references to things other's have provided.

## Bare Zsh

Zsh can be run without RCs using the following command:

```zsh
zsh -dfi
```

When run this way, be careful - all exported environment variables are still set.
Here's the list of environment variables set when run totally clean:

```zsh
% env
TERM_PROGRAM=Apple_Terminal
SHELL=/bin/zsh
TERM=xterm-256color
TMPDIR=/var/folders/3q/pg2lffq50dj8xq787lhtfm2m0000gs/T/
TERM_PROGRAM_VERSION=440
TERM_SESSION_ID=BCC7821F-73F9-451F-9D8F-A948AFF587C5
USER=matt
SSH_AUTH_SOCK=/private/tmp/com.apple.launchd.pSelXw92Wo/Listeners
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/dotnet:~/.dotnet/tools
__CFBundleIdentifier=com.apple.Terminal
PWD=/Users/matt/.config
XPC_FLAGS=0x0
XPC_SERVICE_NAME=0
SHLVL=1
HOME=/Users/matt
LOGNAME=matt
OLDPWD=/Users/matt/.config
LANG=en_US.UTF-8
_=/usr/bin/env
```

## Globbing

[Glob qualifiers][zsh-glob-qualifiers] are options tacked onto a wildcard pattern that filter or modify the match. Some examples:

```zsh
cd $ZDOTDIR
```

Show directories with `/`:

```zsh
$ echo *(/)
plugins zshrc.d zfunctions
```

Show regular files with `.`:

```zsh
$ echo *(.)
.zshenv .zshrc
```

Show symlinks with `@`:

```zsh
$ echo *(@)
.zsh_history
```

Toggle qualifiers to work with symlinks `-`:

```zsh
$ echo *(.-)
.zshenv .zsh_history .zshrc
```

Exclude files with `^`:

```zsh
$ # exclude dotfiles
$ echo ^.*
README.md
```

Null glob, or "don't error on zero results":

```zsh
$ mkdir empty && cd empty
$ echo *
zsh: no matches found: *
$ echo *(N)
```

Files over/unsder a certain size with `L[+|-]n`:

```zsh
$ # files over 1k
$ echo *(Lk+1)
LICENSE README.md
```

## Expansion Modifiers

[Expansion modifiers][zsh-modifiers] change the path stored in a variable.

Set a file path in a variable to play with (assumes OMZ installed):

```zsh
cd $ZSH
filepath=./plugins/extract/extract.plugin.zsh
```

`:a` will expand a relative filepath to an absolute one

```zsh
$ echo $filepath
./plugins/extract/extract.plugin.zsh
$ echo ${filepath:a}
$ZSH/plugins/extract/extract.plugin.zsh
```

`:h` will remove the trailing pathname component, shortening the path by one directory level. This is the 'head' of the pathname, which works like `dirname`.

```zsh
$ echo ${filepath:h}
./plugins/extract
```

`:r` will remove the file extension leaving the 'root' name.

```zsh
$ echo ${filepath:r}
./plugins/extract/extract.plugin
```

`:t` will remove all leading path components leaving the final part, or 'tail'. This works like `basename`.

```zsh
$ echo ${filepath:t}
extract.plugin.zsh
```

`:u` will convert the variable to UPPERCASE. Conversely, `:l` will convert back to lowercase.

```zsh
$ echo ${filepath:u}
./PLUGINS/EXTRACT/EXTRACT.PLUGIN.ZSH
$ echo ${filepath:u:l}
./plugins/extract/extract.plugin
```

[zsh-modifiers]: http://zsh.sourceforge.net/Doc/Release/Expansion.html#Modifiers
[filename-generation]:  http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation
[zsh-glob-qualifiers]:  http://zsh.sourceforge.net/Doc/Release/Expansion.html#Glob-Qualifiers
[glob-filter-stackexchange]: https://unix.stackexchange.com/questions/31504/how-do-i-filter-a-glob-in-zsh
