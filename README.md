# dotconfig

## Prerequisites

Distribution: Arch Linux

- awesome-git
- picom
- zsh
- alacrity: terminal
- tmux: terminal multiplexer
- [neovim](https://github.com/neovim/neovim): editor
- [fzf](https://github.com/junegunn/fzf): fuzzy finder

```bash
pacman -S awesome-git picom-git zsh tmux neovim alacritty fzf
```

Optional tools:

- ripgrep: grep alternative
- lf: terminal file manager
- bat: cat alternative
- fd: find alternative
- [lazygit](https://github.com/jesseduffield/lazygit)

```bash
pacman -S ripgrep lf bat fd lazygit
```

Other utilities:

- asdf: unified version manager
- viu: terminal image viewer
- glow: terminal markdown viewer

```shell
yay -S asdf-vm
```

## Installation

```shell
git clone --recursive git@github.com:ZenLian/dotfiles.git
cd dotfiles
./install.sh
```

## Setup awesome

```sh
pacman -S awesome-git
```
