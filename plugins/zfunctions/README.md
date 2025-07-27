# zfunctions plugin

Use a `$ZDOTDIR/functions` directory to store lazy-loaded zsh function files.

This plugin is similar in concept to the [fish] functions directory.

## Description

This plugin will enable a directory for you to store function files, and adds that directory to your zsh 'fpath' variable.
Any file placed in this directory should contain the innards of a single function definition.
These files will then be "lazy-loaded" by zsh into a function of the same name upon their first call.
The lazy-loading functionality is a built-in feature of zsh called [function autoloading][zsh-autoload].

Your functions path by default is: `${ZDOTDIR:-$HOME/.config/zsh}/functions`.
However, you can optionally override the path by setting the `$ZFUNCDIR` value:

```zsh
ZFUNCDIR=/path/to/my/lazy/zfunctions
```

## Features

The following functions are defined by this plugin:

| Functions | Arguments     | Description                                            |
|:----------|:--------------|:-------------------------------------------------------|
| funced    | \<func-name\> | edit the function specified                            |
| funcsave  | \<func-name\> | save a function to your configured functions directory |

**Note:**
Additionally, the built-in zsh `functions` command will list all the zsh functions that are defined.
The built-in `function` keyword will allow you to define a new function.

## Example

First, make sure you have loaded the zfunctions plugin and started a new zsh session.
You can verify that zfunctions is enabled by running the following:

```zsh
$ (( $+functions[funcsave] )) && echo "zfunctions loaded" || echo "zfunctions not loaded"
zfuncions loaded
```

Next, let's set a $ZFUNCDIR variable for our examples
```zsh
ZFUNCDIR=${ZDOTDIR:-$HOME/.config/zsh}/functions
```

Now, let's make a quick function to test with called 'foo'.

The 'foo' function should always print "bar" and sometimes also print "baz".

From a zsh prompt, define this function:

```zsh
# 'foo' with comments and custom formatting
function foo() {
    # print bar
    echo "bar"
    # and sometimes baz
    if [[ $[${RANDOM}%2] -eq 0 ]]; then
        echo "baz"
    fi
}
```

Next, we can save the function.

```zsh
funcsave foo
```

Now you should have a function file called "foo" in `$ZFUNCDIR`. Let's verify:

```zsh
cat $ZFUNCDIR/foo
```

Notice that the function was reformatted and also that only the function *internals* are saved to the "foo" file, not the function name definition
(ie: the "`function foo() {`" part is purposely missing).

```zsh
# contents of $ZFUNCDIR/foo
echo "bar"
if [[ $[${RANDOM}%2] -eq 0 ]]
then
    echo "baz"
fi
```

Run `zsh` to start a new zsh session to show how lazy loading works.

```zsh
zsh
```

Now, check out the function definition for `foo` by using the `functions`
built-in (notice the trailing "s" on the word function**s**):

```zsh
functions foo
```

You should see this:

```zsh
foo () {
    # undefined
    builtin autoload -XUz ~/.config/zsh/functions
}
```

Now execute the `foo` function once (or do it a few times for fun):

```zsh
# outputs bar, and sometimes baz
$ foo
bar
$ foo
bar
baz
$ foo
bar
```

Now go back and run `functions foo` again and check out the results...
The function definition is now filled in from the `foo` file in your `$ZFUNCDIR`.

```zsh
foo() {
    echo "bar"
    if [[ $[${RANDOM}%2] -eq 0 ]]
    then
        echo "baz"
    fi
}
```

You can edit the 'foo' function by using `funced`:

```zsh
# edit the foo function
funced foo

# or, make a new one entirely
funced bar
```

That's it! Note that you do not need to use `funcsave` or `funced` if you don't prefer to.
Adding files to `$ZFUNCDIR` yourself is also an option. Just remember that your function
files should be named without a file extension (ie: foo, not foo.zsh), and should not
contain the function declaration part (ie: `function foo() {`).

Here's a great first function to create called "up".
Start by typing `funced up` and add this to the file:

```zsh
### $ZFUNCDIR/up
# goes up any number of directories
if [[ "$#" < 1 ]] ; then
    cd ..
else
    local rpt=$(printf "%${1}s")
    local cdstr=${rpt// /..\/}
    cd $cdstr
fi
```

Have fun building your zsh function library!

[omz]: https://github.com/ohmyzsh/ohmyzsh
[fish]: https://fishshell.com
[zsh-autoload]: http://zsh.sourceforge.net/Doc/Release/Functions.html#Autoloading-Functions
