# {{PROJECT_NAME}} AGENTS

本目录是 `agent-repos` monorepo 中的一个独立项目。

## 规则

- 只改动本目录内文件。
- 不提交密钥、`.env` 真实值或构建产物。
- 提交信息 scope 使用项目名：`feat({{PROJECT_NAME}}): ...`。

## 验证

- lint：
- test：
- typecheck：

统一入口：在 `ci.sh` 中串起来，根目录执行 `./scripts/ci-project.sh {{PROJECT_NAME}}`。
