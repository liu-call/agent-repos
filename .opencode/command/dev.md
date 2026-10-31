---
description: 为已有项目开发需求：读取约定、建分支、分析、实现、验证并等待审核
agent: build
---

你将在已有的 monorepo 中为指定项目开发一个需求。用户输入：$ARGUMENTS

输入建议格式：`<project> <需求描述>`。若缺少项目名或需求，先问用户。

## 1. 了解上下文

读取：

- `README.md`、`AGENTS.md`
- `docs/conventions.md`、`docs/workflow.md`
- `projects/<project>/README.md`、`projects/<project>/AGENTS.md`、`projects/<project>/ci.sh`
- 项目源码目录结构

不要修改 `.workspace/`。

## 2. 建分支

```sh
git status --short          # 不干净则报告并停下
git switch main && git pull --ff-only
git switch -c feat/<project>/<slug>
```

`<slug>` 用 2-4 个英文单词，连字符分隔。

## 3. 分析

输出不超过 15 行：目标、改动点、验收标准、风险。然后直接实现。

## 4. 实现

- 只改 `projects/<project>/` 内文件。
- 遵循项目自身 `AGENTS.md` 与现有代码风格。
- 不提交密钥、`.env` 真实值或构建产物。

## 5. 验证

```sh
./scripts/ci-project.sh <project>
```

失败则修复，直到通过。

## 6. 审核点（必须停下）

1. `git add projects/<project>`
2. 输出 `git status --short` 与 `git diff --cached --stat`。
3. 询问用户是否通过。
4. **只有用户明确同意后**才：

```sh
git commit -m "feat(<project>): <描述>"
git push -u origin HEAD
```

并提示创建 PR。未经确认，禁止 commit / push。
