# zdotdir

My `$ZDOTDIR` directory, which contains my zsh configuration.

## Installation

```zsh
# it's a good idea to backup existing files first
find ~ -type f -maxdepth 1 -name '.zsh*' -exec cp {} {}.bak \;

# set the amazing ZDOTDIR variable
export ZDOTDIR=~/.config/zsh

# clone this repo
git clone --recursive git@github.com:mattmc3/zdotdir.git $ZDOTDIR

# change the root .zshenv file
echo "source ~/.config/zsh/.zshenv" >| ~/.zshenv

# load zsh
zsh
```

## Performance

A snappy shell is very important. My config includes a `zbench` alias
that runs zsh 10 times and presents the timings.

The latest benchmark run shows that we load a new shell pretty fast.

```zsh
% # MacBook Air (M1, 2020)
% for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done
        0.09 real         0.05 user         0.03 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys
        0.06 real         0.03 user         0.02 sys

% # MacBook Pro 2.6 GHz 6-Core Intel Core i7
% for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done
        0.32 real         0.08 user         0.15 sys
        0.32 real         0.07 user         0.14 sys
        0.31 real         0.07 user         0.14 sys
        0.31 real         0.07 user         0.14 sys
        0.32 real         0.07 user         0.14 sys
        0.32 real         0.07 user         0.15 sys
        0.32 real         0.08 user         0.14 sys
        0.33 real         0.08 user         0.15 sys
        0.32 real         0.08 user         0.13 sys
        0.29 real         0.07 user         0.11 sys
```

## Resources

- [Terminal Font][terminal-font]: Meslo LG M for Powerline]
- [oh-my-zsh][omz]
- [prezto][prezto]
- [supercharge your terminal with zsh][supercharge-zsh]

[omz]:             https://github.com/ohmyzsh/ohmyzsh
[supercharge-zsh]: https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770
[terminal-font]:   https://github.com/powerline/fonts
[prezto]:          https://github.com/sorin-ionescu/prezto
