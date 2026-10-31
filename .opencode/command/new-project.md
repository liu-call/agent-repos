---
description: 创建新项目：读取仓库约定、脚手架目录、需求分析、分支开发、验证并等待审核
agent: build
---

你将在一个已有的 monorepo 中工作。用户输入：$ARGUMENTS

## 1. 快速了解仓库（只读）

依次读取并按需引用：

- `README.md`、`AGENTS.md`
- `docs/architecture.md`、`docs/conventions.md`、`docs/workflow.md`
- `templates/project-template/` 下所有文件
- `scripts/new-project.sh`、`scripts/ci-project.sh`、`scripts/status-all.sh`

不要修改 `.workspace/` 下任何内容。

## 2. 解析需求

从输入中提取：

- 项目名：kebab-case，小写字母开头（如 `my-agent`）。缺失或非法时先问用户。
- 需求描述、目标、验收标准。关键信息缺失时，一次最多问 1-3 个精炼问题。

若用户只给了项目名、没给需求，就先做通用的可运行骨架，并列出待确认项。

## 3. 建分支 + 脚手架

1. 先 `git status --short`；工作区不干净则报告并停下。
2. `git switch main && git pull --ff-only`
3. `git switch -c feat/<name>/init`
4. `./scripts/new-project.sh <name>`

## 4. 需求分析

先输出不超过 20 行的简短方案：

- 目标 / 非目标
- 目录与模块设计
- 技术选型（未指定时选最小可行方案；影响面大时先问）
- 验收标准

用户通过调用本命令已授权开发，方案输出后直接进入实现；遇到不可逆或高风险选择再确认。

## 5. 实现

- 只在 `projects/<name>/` 内新增/修改代码。
- 根目录只允许更新 `README.md` 的项目索引表。
- 补全 `projects/<name>/README.md`、`AGENTS.md`、`ci.sh`。
- 不提交密钥、`.env` 真实值或构建产物。

## 6. 验证

- 运行 `./scripts/ci-project.sh <name>`，失败则修复。
- 运行 `./scripts/status-all.sh` 确认改动范围。

## 7. 审核点（必须停下）

1. `git add projects/<name> README.md`
2. 输出 `git status --short` 和 `git diff --cached --stat`，简要说明改动与验证结果。
3. 明确询问用户是否通过审核。
4. **只有用户明确同意后**才执行：

```sh
git commit -m "feat(<name>): 初始化项目"
git push -u origin HEAD
```

并提示用户打开终端给出的 PR 链接。未经确认，禁止 commit / push。
