# dotconfig

## install

``` shell
git clone --recursive git@github.com:ZenLian/dotfiles.git
cd dotfiles
./install.sh
```

## required utilities

__nvim__

```
curl -Lo ~/app/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x ~/app/nvim.appimage
```

__ripgrep__

```
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
```

__fzf__

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
