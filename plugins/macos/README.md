# macos

[![License](https://img.shields.io/badge/license-MIT-007EC7)](/LICENSE)
[![built for](https://img.shields.io/badge/built%20for-%20%F0%9F%A6%93%20zshzoo-black)][zshzoo]

> Zsh goodies for MacOS users

## Description

| Command     | Description                                                       |
| ----------- | ----------------------------------------------------------------- |
| `cdf`       | `cd` to the current Finder directory                              |
| `flushdns`  | Flush the DNS cache                                               |
| `hd`        | Hexdump                                                           |
| `hidefiles` | Hide the hidden files in Finder                                   |
| `lmk`       | 'Let me know' speaks on command completion (ex: `sleep 2 && lmk`) |
| `mand`      | Open a specified man page in Dash app                             |
| `manp`      | Open a specified man page in Preview app                          |
| `md5sum`    | MD5 checksummer                                                   |
| `ofd`       | Open the current directory in a Finder window                     |
| `pfd`       | Return the path of the frontmost Finder window                    |
| `pfs`       | Return the current Finder selection                               |
| `pushdf`    | `pushd` to the current Finder directory                           |
| `rmdsstore` | Remove .DS_Store files recursively in a directory                 |
| `sha1sum`   | SHA checksummer                                                   |
| `showfiles` | Show hidden files in Finder                                       |

## Installation

### Install with a Zsh plugin manager

To install using a Zsh plugin manager, add the following to your .zshrc

- [antidote]: `antidote install zshzoo/macos`
- [zcomet]: `zcomet load zshzoo/macos`
- [zgenom]: `zgenom load zshzoo/macos`
- [znap]: `znap source zshzoo/macos`

### Install manually, without a plugin manager

To install manually, first clone the repo:

```zsh
git clone https://github.com/zshzoo/macos ${ZDOTDIR:-~}/.zplugins/macos
```

Then, in your .zshrc, add the following line:

```zsh
source ${ZDOTDIR:-~}/.zplugins/macos/macos.zsh
```

[zshzoo]: https://github.com/zshzoo/zshzoo
[antidote]: https://github.com/mattmc3/antidote
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
