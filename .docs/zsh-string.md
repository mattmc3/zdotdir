# zsh-strings

Fish has a utility for [string maniplulation][string].

This is how you can do the same things with vanilla Zsh.

References:
- [Zsh regex][3]
- [String modifiers][1]
- [String expansion][2]

## Length

Get the length of a string with `#`.
This is similar to `string length` in [fish][length].

```zsh
$ str="abcdefghijklmnopqrstuvwxyz"
$ echo ${#str}
26
```

## Pad/Trim

Left pad a string with the [l expansion flag][2].
Right pad a string with the [r expansion flag][2].
This is similar to `string pad` in [fish][pad].

```zsh
$ str="abc"
$ echo ${(l(10)(-))str}
-------abc
$ echo ${(r(10)(ABC))str}
abcABCABCA
```

The docs can be confusing. They show the syntax as `l:expr::string1::string2:`, which
uses colons instead of the more readable parens. Don't be confused by the double colon,
which is really just the closing/opening combo `)(`. If you choose to follow the docs,
the syntax looks like this:

```zsh
$ str="abc"
$ echo ${(r:10::-:)str}
abc-------
```

Trim requires the use of `sed`. This is similar to `string trim` in [fish][trim].

```zsh
$ str="   \t\t\t   abc   \t\t\t   "
$ echo "$str" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
abc
```

## Substring

Get a substing from string with comma indexing `[start,end]`.
This is similar to `string sub` in [fish][sub].

```zsh
$ str="abcdefghijklmnopqrstuvwxyz"
$ echo ${str[3,6]}
cdef
```

You can also use the `${var:offset:length}` syntax:

```zsh
$ str="abcdefghijklmnopqrstuvwxyz"
$ echo ${str:3:6}
defghi
$ echo ${str:(-4)}
wxyz
```

## Repeat

Repeat a string by using `printf`.
This is similar to `string repeat` in [fish][repeat].

```zsh
$ str="abc"
$ abc3=$(printf "$str%.0s" {1..3})
$ echo $abc3
abcabcabc
```

## Escape/Unescape

Escape (quote) strings with the [q modifier][1].
This is similar to `string escape` in [fish][escape].

```zsh
$ str="3 tabs \t\t\t."
$ echo "${str:q}"
3\ tabs\ \t\t\t.
```

Unescape (unquote) strings with the [Q modifier][1].
This is similar to `string unescape` in [fish][unescape].

```zsh
$ str="3 backticks \`\`\`."
$ esc="${str:q}"
$ echo $esc
3\ backticks\ \`\`\`.
$ echo "${esc:Q}"
3 backticks ```.
```

## Join/Split

Join strings with the [j expansion flag][2].
This is similar to `string join` in [fish][join].

```zsh
$ words=(abc def ghi)
$ sep=:
$ echo ${(pj.$sep.)words}
abc:def:ghi
```

A common join seperator is the null character.
This is similar to `string join0` in [fish][join0].

```zsh
$ words=(abc def ghi)
$ sep="\x00"
$ echo ${${(pj.$sep.)words}:q}
abc\x00def\x00ghi
```

Split strings with the [s expansion flag][2].
This is similar to `string split` in [fish][split].

- `@`: Preserves empty elements. _"In double quotes, array elements are put into separate words"_.
- `p`: Use print syntax. _"Recognize the same escape sequences as the print."_
- `s`: Split. _"Force field splitting at the separator string."_

```zsh
$ str="a:b::c"
$ sep=:
$ printf '%s\n' "${(@ps.$sep.)str}"
a
b

c
```

A common split seperator is the null character.
This is similar to `string split0` in [fish][split0].

```zsh
$ str="abc\x00def\x00ghi"
$ sep="\x00"
$ arr=(${(ps.$sep.)str})
$ printf '%s\n' $arr
abc
def
ghi
```

## Upper/Lower

Convert a string to uppercase with the [u modifier][1].
This is similar to `string upper` in [fish][upper].

```zsh
$ str="AbCdEfGhIjKlMnOpQrStUvWxYz"
$ echo "${str:u}"
ABCDEFGHIJKLMNOPQRSTUVWXYZ
```

Convert a string to lowercase with the [l modifier][1].
This is similar to `string lower` in [fish][lower].

```zsh
$ str="AbCdEfGhIjKlMnOpQrStUvWxYz"
$ echo "${str:l}"
abcdefghijklmnopqrstuvwxyz
```

## Match/Replace

```zsh
str="The following are zip codes: 78884 90210 99513"
setopt REMATCH_PCRE
if [[ $str =~ '\d{5}' ]]; then
  echo "contains zip codes"
else
  echo "no zip codes found"
fi
```

```zsh
str="https://gist.github.com/mattmc3/110eca74a876154c842423471b8e5cbb"
zmodload zsh/pcre
pattern='^(ftp|https?)://'
pcre_compile -smx $pattern
pcre_match -b -- $str
if [[ $? -ne 0 ]]; then
  echo "no match..."
else
  echo "match found. (match: $MATCH, position: $ZPCRE_OP)"
fi
```

## TODO

Collect, replace, trim.

[1]: https://zsh.sourceforge.io/Doc/Release/Expansion.html#Modifiers
[2]: https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags
[3]: https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fpcre-Module
[collect]: https://fishshell.com/docs/current/cmds/string-collect.html
[escape]: https://fishshell.com/docs/current/cmds/string-escape.html
[join]: https://fishshell.com/docs/current/cmds/string-join.html
[join0]: https://fishshell.com/docs/current/cmds/string-join0.html
[length]: https://fishshell.com/docs/current/cmds/string-length.html
[lower]: https://fishshell.com/docs/current/cmds/string-lower.html
[match]: https://fishshell.com/docs/current/cmds/string-match.html
[pad]: https://fishshell.com/docs/current/cmds/string-pad.html
[repeat]: https://fishshell.com/docs/current/cmds/string-repeat.html
[replace]: https://fishshell.com/docs/current/cmds/string-replace.html
[split]: https://fishshell.com/docs/current/cmds/string-split.html
[split0]: https://fishshell.com/docs/current/cmds/string-split0.html
[string]: https://fishshell.com/docs/current/cmds/string.html
[sub]: https://fishshell.com/docs/current/cmds/string-sub.html
[trim]: https://fishshell.com/docs/current/cmds/string-trim.html
[unescape]: https://fishshell.com/docs/current/cmds/string-unescape.html
[upper]: https://fishshell.com/docs/current/cmds/string-upper.html
