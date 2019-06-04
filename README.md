# dotfiles.zsh

My ~/.zsh directory, which contains my zsh configuration.

## Installation

```zsh
# its a good idea to backup existing files first
find ~ -type f -maxdepth 1 -name '.zsh*' -exec cp {} {}.bak \;

# set the amazing ZDOTDIR variable
export ZDOTDIR=~/.zsh

# clone this repo
git clone git@github.com:mattmc3/dotfiles.zsh.git $ZDOTDIR

# place the .zshenv file
ln -sf $ZDOTDIR/.zshenv ~/.zshenv

# load zsh
zsh
```

### Alternative

If you would rather not deal with symlinks, you can easily make a simple
`~/.zshenv` file.

```zsh
echo "export ZDOTDIR=~/.zsh" > ~/.zshenv
echo '[[ -f "$ZDOTDIR"/.zshenv ]] && source "$ZDOTDIR"/.zshenv' >> ~/.zshenv
```

## Performance

A snappy shell is very important. My config includes a `zbenchmark` alias
that runs zsh 10 times and presents the timings.

The latest benchmark run shows that we load a new shell pretty fast.

```zsh
% # 2.5 GHz i7 MacBook Pro
% zbenchmark
        0.09 real         0.05 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
        0.08 real         0.04 user         0.03 sys
```
