# Pair Extraordinaire: Claude as Co-Author

验证目标:AI(Claude)能否作为 co-author 触发 GitHub Pair Extraordinaire 成就徽章。

## 结论(2026-08 验证)

**可以。** 关键事实:

1. `github.com/claude` 是真实存在的 **User 类型账号**(uid 81847,非 Bot),由 Anthropic 官方持有
   (company: `@anthropics`,blog: anthropic.com/claude-code)。
2. `noreply@anthropic.com` 关联到该账号 —— commit 页面的 authors 数据会解析出
   `{"login": "claude", "path": "/claude"}`。
3. 先例:[thebardchat/AI-Trainer-MAX#3](https://github.com/thebardchat/AI-Trainer-MAX/pull/3)
   (2026-03)用 `Co-Authored-By: Claude ... <noreply@anthropic.com>` 的 commit 开 PR 并合并,
   作者成功获得 Pair Extraordinaire 徽章。

## 本 PR 的操作方式

```bash
git checkout -b docs/pair-extraordinaire-claude main
# 修改文件后:
git commit -m "docs: verify Pair Extraordinaire with Claude co-author" \
  -m "Co-Authored-By: Claude <noreply@anthropic.com>"
git push -u origin docs/pair-extraordinaire-claude
gh pr create --fill
gh pr merge --merge   # 普通 merge,让带 trailer 的 commit 本体进入默认分支
```

## 两种等效的 Claude trailer 邮箱写法

| 邮箱 | 说明 |
| --- | --- |
| `noreply@anthropic.com` | Claude Code 默认追加的格式,已实证有效 |
| `81847+claude@users.noreply.github.com` | GitHub 标准 noreply 格式(uid+login),理论上等效 |

## 真人协作者注意事项(来自本仓库 #7–#14 的实验)

- trailer 必须写在 commit message **正文**,格式严格为 `Co-authored-by: Name <email>`
- 邮箱须能映射到对方 GitHub 账号,最稳的是 noreply 格式 `uid+login@users.noreply.github.com`
- PR 必须合并进**默认分支**;squash 合并时 GitHub 会自动把 trailer 保留进 squash commit
- 徽章发放有延迟,几分钟到 24 小时不等
- 反面案例:PR #13 中 `Co-authered-by: Beancurd beancurdpachelbel@gmail.com`(拼写错误 +
  缺尖括号)不计入
