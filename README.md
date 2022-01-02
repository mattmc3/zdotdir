# zdotdir

My `$ZDOTDIR` [dotfiles] directory, which contains my zsh configuration.

## Installation

It's a good idea to backup existing files first:

```zsh
setopt extended_glob
zfiles=(
  ${ZDOTDIR:-~}/.zlogin(.N)
  ${ZDOTDIR:-~}/.zlogout(.N)
  ${ZDOTDIR:-~}/.zpreztorc(.N)
  ${ZDOTDIR:-~}/.zprofile(.N)
  ${ZDOTDIR:-~}/.zsh_history(.N)
  ${ZDOTDIR:-~}/.zshenv(.N)
  ${ZDOTDIR:-~}/.zshrc(.N)
)
mkdir -p ~/.bak
for zfile in $zfiles; do
  cp $zfile ~/.bak
done
unset zfile zfiles
```

Install this dotfiles repo to your `$ZDOTDIR`:

```zsh
# set the amazing ZDOTDIR variable
export ZDOTDIR=~/.config/zsh

# clone this repo
git clone --recursive git@github.com:mattmc3/zdotdir.git $ZDOTDIR

# change the root .zshenv file to use ZDOTDIR
cat << 'EOF' >| ~/.zshenv
export ZDOTDIR=~/.config/zsh
[[ -f $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv
EOF

# load zsh
zsh
```

## Frameworks

I like [Prezto][prezto] a lot, but it wasn't quite fast enough for me
so I took the best parts from it and other frameworks and made
[ZshZoo][zshzoo]. This made my Zsh config lightning fast, and
also lets me still pull other plugins to enhance my Zsh config.

## Performance

A snappy shell is very important. My config includes a `zbench` alias
that runs zsh 10 times and presents the timings.

The latest benchmark run shows that we load a new shell pretty fast.

```zsh
% # MacBook Air (M1, 2020)
% alias zbench='for i in $(seq 10); do; /usr/bin/time zsh -i -c exit; done'
% zbench
        0.04 real         0.02 user         0.01 sys
        0.02 real         0.01 user         0.01 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.01 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.00 sys
        0.02 real         0.01 user         0.01 sys

% # MacBook Pro 2.6 GHz 6-Core Intel Core i7
% alias zbench='for i in $(seq 10); do; /usr/bin/time zsh -i -c exit; done'
% zbench
        0.08 real         0.03 user         0.012 sys
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

## Look-and-feel

### Prompt

I use the [Starship][starship] prompt. My [toml config is here][starship-toml]. This is
what my prompt looks like:

![zebrafish](https://raw.githubusercontent.com/mattmc3/zdotdir/resources/img/zebrafish.png)

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

iTerm2 has some awesome [color schemes][iterm2-colors]. You can use them for more than
just iTerm2.

I use Space Gray:

<p align="center">
  <img alt="space gray" src="https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/screenshots/space_gray.png?raw=true"/>
</p>

## Resources

- [zshzoo][zshzoo]
- [zebrafish][zebrafish]
- [prezto][prezto]
- [oh-my-zsh][ohmyzsh]
- [supercharge your terminal with zsh][supercharge-zsh]

[dotfiles]:         https://dotfiles.github.io/
[homebrew]:         https://brew.sh
[iterm2-colors]:    https://github.com/mbadolato/iTerm2-Color-Schemes
[nerd-fonts]:       https://github.com/ryanoasis/nerd-fonts
[ohmyzsh]:          https://github.com/ohmyzsh/ohmyzsh
[prezto]:           https://github.com/sorin-ionescu/prezto
[starship-toml]:    https://github.com/mattmc3/zdotdir/blob/main/prompt/starship.toml
[starship]:         https://starship.rs
[supercharge-zsh]:  https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770
[zebrafish]:        https://github.com/mattmc3/zebrafish
[zshzoo]:           https://github.com/zshzoo/zshzoo
