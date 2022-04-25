# dotconfig

## install

``` shell
git clone --recursive git@github.com:ZenLian/dotfiles.git
cd dotfiles
./install.sh
```

## Prerequisites

[sheldon](https://github.com/rossmacarthur/sheldon)(only if auto installation
failed)

```bash
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
```

nvim(v0.7.0+)

```bash
curl -Lo ~/app/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x ~/app/nvim.appimage
```

ripgrep

```bash
sudo apt install ripgrep
```

[fzf](https://github.com/junegunn/fzf)(only if auto installation failed)

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

[lazygit](https://github.com/jesseduffield/lazygit)

