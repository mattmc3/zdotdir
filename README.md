# zdotdir

My ~/.config/zsh directory, which contains my zsh configuration.

## Installation

```zsh
# it's a good idea to backup existing files first
find ~ -type f -maxdepth 1 -name '.zsh*' -exec cp {} {}.bak \;

# set the amazing ZDOTDIR variable
export ZDOTDIR=~/.config/zsh

# clone this repo
git clone git@github.com:mattmc3/zdotdir.git $ZDOTDIR

# symlink the .zshenv file (alternatively, you can just source it from ~/.zshenv)
ln -sf $ZDOTDIR/.zshenv ~/.zshenv

# load zsh
zsh
```

### Alternative

If you would rather not deal with symlinks, you can easily make a simple
`~/.zshenv` file.

```zsh
cat << 'EOF' > $HOME/.zshenv
export ZDOTDIR=~/.config/zsh
. "$ZDOTDIR/.zshenv"
EOF
```

## Performance

A snappy shell is very important. My config includes a `zbench` alias
that runs zsh 10 times and presents the timings.

The latest benchmark run shows that we load a new shell pretty fast.

```zsh
% # 2.5 GHz i7 MacBook Pro
% for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done
        0.07 real         0.03 user         0.02 sys
        0.07 real         0.03 user         0.02 sys
        0.07 real         0.03 user         0.02 sys
        0.07 real         0.03 user         0.02 sys
        0.07 real         0.03 user         0.03 sys
        0.07 real         0.03 user         0.03 sys
        0.06 real         0.03 user         0.02 sys
        0.07 real         0.03 user         0.03 sys
        0.07 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys

% # 2.8 GHz i7 MacBook Pro
% for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done
        0.06 real         0.03 user         0.02 sys
        0.05 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.05 real         0.03 user         0.02 sys
        0.05 real         0.03 user         0.02 sys
        0.05 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.05 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
```

## Resources

- [Terminal Font][terminal-font]: Meslo LG M for Powerline
- [zgen][zgen]
- [antibody][antibody]
- [oh-my-zsh][omz]
- [supercharge your terminal with zsh][supercharge-zsh]

[antibody]:        https://getantibody.github.io/
[supercharge-zsh]: https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770
[omz]:             https://github.com/robbyrussell/oh-my-zsh/tree/master/lib
[terminal-font]:   https://github.com/powerline/fonts
[zgen]:            https://github.com/tarjoilija/zgen
