# zdotdir

My `$ZDOTDIR` [dotfiles] directory, which contains my zsh configuration.

## My Terminal

![My Terminal][zdotdir_gif]

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

## Performance

A snappy shell is very important. My config includes a `zbench` alias
that runs zsh 10 times and presents the timings.

The latest benchmark run shows that we load a new shell pretty fast.

```zsh
% # MacBook Air (M1, 2020)
% for i in $(seq 10); do; /usr/bin/time zsh -lic exit; done
        0.08 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys
        0.07 real         0.04 user         0.03 sys

% # pure prompt
% zsh-bench
creates_tty=0
has_compsys=1
has_syntax_highlighting=1
has_autosuggestions=1
has_git_prompt=0
first_prompt_lag_ms=100.919
first_command_lag_ms=109.839
command_lag_ms=50.802
input_lag_ms=6.639
exit_time_ms=79.399

# prezto prompt
creates_tty=0
has_compsys=1
has_syntax_highlighting=1
has_autosuggestions=1
has_git_prompt=0
first_prompt_lag_ms=108.525
first_command_lag_ms=117.335
command_lag_ms=51.511
input_lag_ms=4.731
exit_time_ms=78.831

# starship prompt
creates_tty=0
has_compsys=1
has_syntax_highlighting=1
has_autosuggestions=1
has_git_prompt=1
first_prompt_lag_ms=142.011
first_command_lag_ms=148.699
command_lag_ms=101.397
input_lag_ms=7.485
exit_time_ms=79.402
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

iTerm2 has some awesome [color schemes][iterm2-colors]. You can use them for more than
just iTerm2.

I use Space Gray:

<p align="center">
  <img alt="space gray" src="https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/screenshots/space_gray.png?raw=true"/>
</p>

## Resources

- [zshzoo][zshzoo]
- [zebrafish][zebrafish]
- [zsh_unplugged][zsh_unplugged]
- [prezto][prezto]
- [oh-my-zsh][oh-my-zsh]
- [supercharge your terminal with zsh][supercharge-zsh]

[dotfiles]:         https://dotfiles.github.io/
[homebrew]:         https://brew.sh
[iterm2-colors]:    https://github.com/mbadolato/iTerm2-Color-Schemes
[nerd-fonts]:       https://github.com/ryanoasis/nerd-fonts
[oh-my-zsh]:        https://github.com/ohmyzsh/ohmyzsh
[prezto]:           https://github.com/sorin-ionescu/prezto
[starship-toml]:    https://github.com/mattmc3/zdotdir/blob/main/prompt/starship.toml
[starship]:         https://starship.rs
[supercharge-zsh]:  https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770
[zebrafish]:        https://github.com/mattmc3/zebrafish
[zshzoo]:           https://github.com/zshzoo/zshzoo
[zsh_unplugged]:    https://github.com/mattmc3/zsh_unplugged
[zdotdir_gif]:      https://raw.githubusercontent.com/mattmc3/zdotdir/resources/img/zdotdir.gif
