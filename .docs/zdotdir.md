# ZDOTDIR

> A simple guide to moving your Zsh files out of your `$HOME`

This guide shows you how to move your Zsh files out of your home directory into a dedicated Zsh config directory.

## Pick a path

Assuming you want to put your Zsh config in `~/.config/zsh`, run the following from an interactive Zsh session:

```zsh
export ZDOTDIR=~/.config/zsh
mkdir -p $ZDOTDIR
```

These commands will set the `ZDOTDIR` variable to your new Zsh home, and then ensure that the directory is properly created.

## Move your Zsh dotfiles

```zsh
zdotfiles=(
  .zlog{in,out}
  .zprofile
  .zsh{env,rc,_history}
)
for file in $zdotfiles
do
  [[ -f ~/$file ]] && echo mv ~/$file $ZDOTDIR
done
```
