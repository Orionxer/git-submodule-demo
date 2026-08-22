# Git Submodule Demo

这个仓库演示如何使用 Git 子模块，并把
[`rxi/json.lua`](https://github.com/rxi/json.lua) 固定在 `v0.1.0`。

## 克隆并初始化子模块

推荐一次完成：

```bash
git clone --recurse-submodules <main-repository-url>
```

如果已经普通克隆了主仓库：

```bash
git submodule update --init --recursive
```

## 查看子模块状态

```bash
git submodule status
git -C third_party/json.lua describe --tags --exact-match
```

第二条命令应输出：

```text
v0.1.0
```

也可以运行仓库提供的检查脚本：

```bash
./scripts/check-submodule-tag.sh
```

## 运行示例

系统安装了 Lua 时执行：

```bash
lua example.lua
```

## 将子模块升级到其他 tag

```bash
git -C third_party/json.lua fetch --tags
git -C third_party/json.lua checkout v0.1.1
git add third_party/json.lua
git commit -m "Update json.lua submodule to v0.1.1"
```

主仓库记录的是子模块的 commit ID。`v0.1.0` 是指向该 commit 的 tag，
因此子模块处于 detached HEAD 状态是正常现象。
