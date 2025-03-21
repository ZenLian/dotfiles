# dotconfig

## 安装

### Ubuntu

```shell
sudo apt install stow tmux zsh fzf ripgrep fd-find
```

Ubuntu 的 tmux 版本过低，需要手动编译 tmux:

```shell
# 安装编译需要的包
sudo apt install build-essential libevent-dev ncurses-dev bison pkg-config
# 编译、安装
wget https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz
tar xf tmux-3.5a.tar.gz
cd tmux-3.5a.tar.gz
./configure --prefix=$HOME/.local
make -j8 && make install
```

fzf 版本过低，需要手动编译。

neovim 下载 appimage 版本：

```shell
cd ~/.local/bin
nvim-0.10.0.appimage
```

## Prerequisites

- Terminal Multiplexer: tmux
- Shell: zsh
- Editor: neovim
- Browser: microsoft-edge-stable
- File Explorer
  - lf(terminal)
  - thunar(gui) ~~dolphin~~
- Screenshot: flameshot
- Video:
  - xf86-video-[admgpu/intel/nouveau]
  - brightnessctl
- Audio:
  - alsa-utils
- Network:
  - Network Manager
  - nmcli

Optional:

- Fuzzy Finder: fzf
- Grep Alternative: ripgrep
- File Manager: lf
- Cat Alternative: bat
- find alternative: fd

```bash
pacman -S awesome-git picom-git rofi alacritty
pacman -S zsh tmux neovim fzf ripgrep lf bat fd
```

Optional tools:

- [lazygit](https://github.com/jesseduffield/lazygit)
- asdf: unified version manager
- viu: terminal image viewer
- glow: terminal markdown viewer

```bash
yay -S asdf-vm
```

## Installation

```bash
git clone --recursive git@github.com:ZenLian/dotfiles.git
cd dotfiles
./install.sh
```
