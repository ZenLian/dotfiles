# dotconfig

## 下载和安装

```shell
git clone --recursive git@github.com:ZenLian/dotfiles.git
```

`clone` 时如果没有加 `--recursive`，需要手动更新 git 子模块：

```shell
git submodule init
git submodule update
```

安装某个配置，比如 vim：

```shell
cd dotfiles
./install vim
```

## 前置包安装

### Arch

必须的组件：

```shell
sudo pacman -S git stow tmux zsh neovim fzf ripgrep fd
```

可选组件：

```shell
sudo pacman -S zoxide eza bat git-delta
```

### Ubuntu

```shell
sudo apt install stow zsh fzf ripgrep fd-find
```

tmux 版本过低，需要手动编译 tmux:

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

fzf 版本过低，需要手动下载，以 v0.54.3 为例：

```shell
wget https://github.com/junegunn/fzf/releases/download/v0.54.3/fzf-0.54.3-linux_amd64.tar.gz
tar xf fzf-0.54.3-linux_amd64.tar.gz
```

neovim 下载 appimage 版本：

```shell
cd ~/.local/bin
wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.appimage
chmod +x nvim-*
ln -sf nvim-*.appimage nvim
```

### 远程环境

Windows 端需要安装 NerdFont 字体:

- https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraMono.zip

## 桌面环境

- 桌面：hyprland
- 状态栏：waybar
- 终端：kitty

## FAQ

### bat 主题未生效

安装 bat 配置文件之后，更新缓存以使主题生效：

```
bat cache --build
```
