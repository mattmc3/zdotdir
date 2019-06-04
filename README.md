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
