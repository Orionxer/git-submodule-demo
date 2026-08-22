#!/bin/sh

set -eu

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
submodule_path="$repository_root/third_party/json.lua"
expected_tag="v0.1.0"

if ! git -C "$submodule_path" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "错误：子模块尚未初始化，请运行 git submodule update --init --recursive" >&2
    exit 1
fi

if ! actual_tag=$(git -C "$submodule_path" describe --tags --exact-match 2>/dev/null); then
    echo "错误：子模块当前提交不对应任何 tag" >&2
    exit 1
fi

if [ "$actual_tag" != "$expected_tag" ]; then
    echo "错误：期望 $expected_tag，当前为 $actual_tag" >&2
    exit 1
fi

echo "子模块版本正确：$actual_tag"
