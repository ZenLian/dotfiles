# dotfiles-graphical

ArchLinux 桌面环境

- 框架：wayland
- 桌面：niri
- 状态栏：waybar
- 终端：kitty

## 下载和安装

```shell
git clone --recursive git@github.com:ZenLian/dotfiles.git -b graphical
```

`clone` 时如果没有加 `--recursive`，需要手动更新 git 子模块：

```shell
git submodule init
git submodule update
```

安装配置:

```shell
cd dotfiles
./install niri
```

## 前置包安装

```shell
sudo pacman -S niri waybar
```

