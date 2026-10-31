# AGENTS.md

本仓库是一个 **monorepo**，包含多个彼此独立的项目。根目录即 git 仓库。

## 规则

- 每个项目位于 `projects/<name>/`，项目内文件自包含；共享代码放 `packages/`。
- 改动只在目标项目目录内进行；跨项目改动分开提交、分开说明。
- 新增项目统一用 `./scripts/new-project.sh <name>`，不要手工复制目录。
- `.workspace/` 是本地私有区（第三方 clone / 临时 / 归档），**禁止提交**。
- 一个任务一个分支；提交前先 `git status` 确认只包含预期文件。
- 未经用户明确要求，不要 commit、push 或创建 PR。
- 不要提交密钥、token 或 `.env` 真实值，只提交 `.env.example`。
- 提交信息遵循 Conventional Commits，scope 用项目名：`feat(<name>): ...`。

## 验证

各项目以自身 `projects/<name>/AGENTS.md`、`README.md`、`ci.sh` 为准。
根层可运行：

```sh
./scripts/ci-project.sh <name>
./scripts/status-all.sh
```
