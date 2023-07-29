# 个人用简易NeoVim配置

简易NeoVim配置,仅适配Linux, macOS, FreeBSD. 功能不多，够用即可。

## 部署

下载后，放置在~/.config/nvim/目录下。

### 准备工作

- 安装NeoVim

- 本项目采用Packer作为包管理，首次使用前执行以下命令

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
- 本项目默认开启Lua, Python, Javascript/Typescript/JSX/TSX, CSS语言服务支持。
相关语言服务可通过系统包管理安装
```
# Arch Linux为例
pacman -S lua-language-server pyright typescript-language-server
```
其他语言服务及安装方式可以官方网站查找：https://langserver.org/

### 安装
在确保Packer安装后，在Shell中输入以下命令进入NeoVim: 
```
nvim
```
进入NeoVim后，在正常模式执行以下命令，安装插件: 
```
:PackerInstall
:TSInstall
```

确保插件安装后即可完成全部安装.


## 许可证

本项目采用MIT许可证 - 具体内容详见文件[LICENSE.md](LICENSE.md).
## 致谢
本项目[lua/keyword.lua](lua/keyword.lua)文件源自[glepnir](https://github.com/glepnir)。本项目根据MIT许可证使用源码，感谢其开源分享。


