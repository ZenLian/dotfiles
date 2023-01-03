# dotconfig

## Prerequisites

- Window Server: x-org
- Window Manager: awesome-git
- Window Compositor: picom-git
- Launcher: rofi
- Terminal: alacrity
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
