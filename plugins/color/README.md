# Color

> Make the terminal more colorful

## Features

This plugin adds the following features:

| feature                     | description                                             |
| --------------------------- | ------------------------------------------------------- |
| autoload `colors`           | Includes Zsh built in [colors][colors]                  |
| colorize man pages          | Running man now shows docs in color                     |
| colorize `ls`               | Uses `dircolors` if found to set `LSCOLORS`/`LS_COLORS` |
| add color flags to commands | Add colors for `grep`, `ls`, and `diff` commands        |
| colorize completions        | Add zstyles for list-colors                             |

## Aliases

This plugin adds/modifies the following aliases:

| alias      | description                               |
| ---------- | ----------------------------------------- |
| `diff`     | Adds `--color` flag                       |
| `grep`     | Adds `--color=auto` flag                  |
| `ls`       | Adds `--color=auto` flag                  |
| `colormap` | Show a colormap with terminal color codes |

## Variables

This plugin sets the following variables:

| variable          | description                   |
| ----------------- | ----------------------------- |
| `LESS_TERMCAP_md` | start less bold style         |
| `LESS_TERMCAP_mb` | start less blink style        |
| `LESS_TERMCAP_so` | start less standout style     |
| `LESS_TERMCAP_us` | start less underline style    |
| `LESS_TERMCAP_se` | end less standout style       |
| `LESS_TERMCAP_ue` | end less underline style      |
| `LESS_TERMCAP_me` | end less bold/blink style     |
| `LS_COLORS`       | ls colors for GNU systems     |
| `LSCOLORS`        | ls colors for BSD systems     |
| `CLICOLOR`        | Enable colors for BSD systems |

## Customizations

This plugin allows for the following customizations:

To cache the results of the `dircolors` call, you can set:

`zstyle ':zephyr:plugin:color' 'use-cache' 'yes'`

To always use caching to speed up expensive calls, you can set:

`zstyle ':zephyr:plugin:*' 'use-cache' 'yes'`

[colors]: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-colors
