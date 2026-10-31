# Conventions

## 命名

- 项目名：kebab-case，小写字母开头，如 `my-agent`。
- 目录：`projects/<name>/`、`packages/<lib>/`。
- 标签：`project:<name>`、`type:feat|bug|chore`、`status:todo|doing|review`。

## 分支

- `feat/<project>/<slug>`
- `fix/<project>/<slug>`
- `chore/<slug>`

从 `main` 拉出，合并后删除。

## 提交

Conventional Commits，scope 用项目名：

```
feat(my-agent): 新增工具调用
fix(my-agent): 修复超时
docs(my-agent): 更新说明
chore: 调整根脚本
```

## 发布

- Tag：`<project>/vX.Y.Z`，如 `my-agent/v0.1.0`。
- 每个项目维护自己的 CHANGELOG（可选）。

## 审核

- 首次 bootstrap 可直接提交 `main`。
- 之后一律走 PR：推送分支 → 创建 PR → 审核通过后合并。
- PR 需关联 Issue，并填写验证方式。
