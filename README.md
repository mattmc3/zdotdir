# zdotdir

My `$ZDOTDIR` directory, which contains my zsh configuration.

## Installation

It's a good idea to backup existing files first:

```zsh
setopt extended_glob
zfiles=(
  ${ZDOTDIR:-$HOME}/.zlogin(.N)
  ${ZDOTDIR:-$HOME}/.zlogout(.N)
  ${ZDOTDIR:-$HOME}/.zpreztorc(.N)
  ${ZDOTDIR:-$HOME}/.zprofile(.N)
  ${ZDOTDIR:-$HOME}/.zsh_history(.N)
  ${ZDOTDIR:-$HOME}/.zshenv(.N)
  ${ZDOTDIR:-$HOME}/.zshrc(.N)
)
mkdir -p ~/.bak
for zfile in $zfiles; do
  cp $zfile ~/.bak
done
```

Install this dotfiles repo to your $ZDOTDIR:

```zsh
# set the amazing ZDOTDIR variable
export ZDOTDIR=~/.config/zsh

# clone this repo
git clone --recursive git@github.com:mattmc3/zdotdir.git $ZDOTDIR

# change the root .zshenv file
echo "source ~/.config/zsh/.zshenv" >| ~/.zshenv

# load zsh
zsh
```

## Frameworks

I like [Prezto][prezto] a lot, but it wasn't quite fast enough for me
so I took the best parts from it and other frameworks and made
[Zebrafish][zebrafish]. This made my Zsh config lightning fast, and
also lets me still pull other plugins to enhance my Zsh config.

## Performance

A snappy shell is very important. My config includes a `zbench` alias
that runs zsh 10 times and presents the timings.

The latest benchmark run shows that we load a new shell pretty fast.

```zsh
% # MacBook Air (M1, 2020)
% for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done
        0.06 real         0.03 user         0.02 sys
        0.05 real         0.02 user         0.02 sys
        0.05 real         0.02 user         0.02 sys
        0.05 real         0.02 user         0.02 sys
        0.05 real         0.02 user         0.02 sys
        0.05 real         0.02 user         0.02 sys
        0.05 real         0.02 user         0.02 sys
        0.05 real         0.02 user         0.02 sys
        0.05 real         0.02 user         0.02 sys
        0.05 real         0.02 user         0.02 sys

% # MacBook Pro 2.6 GHz 6-Core Intel Core i7
% for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done
        0.13 real         0.05 user         0.06 sys
        0.11 real         0.04 user         0.06 sys
        0.11 real         0.04 user         0.06 sys
        0.11 real         0.04 user         0.05 sys
        0.11 real         0.04 user         0.06 sys
        0.11 real         0.04 user         0.05 sys
        0.11 real         0.04 user         0.05 sys
        0.11 real         0.04 user         0.05 sys
        0.11 real         0.05 user         0.06 sys
        0.11 real         0.04 user         0.05 sys
```

## Look-and-feel

### Fonts

Install [nerd fonts][nerd-fonts] via homebrew:

```zsh
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-inconsolata-nerd-font
brew install --cask font-sauce-code-pro-nerd-font
```

### Color schemes

iTerm2 has some awesome [color schemes][iterm2-colors]. You can use them for more than just iTerm2.

I use Space Gray:

<p align="center">
  <img alt="space gray" src="https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/screenshots/space_gray.png?raw=true"/>
</p>

## Resources

- [prezto][prezto]
- [oh-my-zsh][omz]
- [supercharge your terminal with zsh][supercharge-zsh]

[omz]:              https://github.com/ohmyzsh/ohmyzsh
[supercharge-zsh]:  https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770
[nerd-fonts]:       https://github.com/ryanoasis/nerd-fonts
[prezto]:           https://github.com/sorin-ionescu/prezto
[zebrafish]:        https://github.com/zshzoo/zebrafish
[homebrew]:         https://brew.sh
[iterm2-colors]:    https://github.com/mbadolato/iTerm2-Color-Schemes
