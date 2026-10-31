# Architecture

## 定位

`agent-repos` 是一个公开的 **monorepo**，用来容纳多个彼此独立的 AI / agent 项目。

- 一个仓库、一次 clone、一个公开入口。
- 项目之间互不依赖；需要复用时才提取到 `packages/`。
- 私有/第三方内容放在 `.workspace/`，永不提交。

## 分层

```
根层     README / LICENSE / AGENTS / docs / scripts / .github
项目层   projects/<name>/     每个项目自包含
共享层   packages/            跨项目共享库（按需）
模板层   templates/           新项目脚手架
私有层   .workspace/          gitignored
```

## 设计原则

1. **项目自包含**：依赖、构建、测试命令都在项目目录内声明。
2. **根层只编排**：根脚本不理解具体语言，只按约定调用 `projects/<name>/ci.sh`。
3. **异构友好**：不强制统一包管理器；需要时在根加 `justfile`/`Makefile`。
4. **按路径触发**：CI 只跑变更项目，避免全仓构建。
5. **可拆分**：项目变大或需要独立发布时，用 `git subtree split -P projects/<name>` 拆出。

## 扩展点

- 新项目：`./scripts/new-project.sh <name>`
- 共享代码：`packages/<lib>/`，由使用方按相对路径或包管理器引用。
- 项目级 CI：`projects/<name>/ci.sh`
- 通知：`.github/workflows/notify-feishu.yml`（可选，需 `FEISHU_WEBHOOK`）
