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
