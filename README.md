# agent-repos

多个自研 AI / agent 项目的公开 monorepo。一个仓库、一次 clone、每个项目独立目录。

- 公开地址：<https://github.com/liu-call/agent-repos>
- 项目统一放在 `projects/<name>/`，共享代码放 `packages/`。
- 第三方 clone、私有实验、临时文件放在 `.workspace/`（已 gitignore，不公开）。

## 目录结构

| 路径 | 用途 |
| --- | --- |
| `projects/<name>/` | 自研公开项目，每个目录自包含（README/AGENTS/构建脚本） |
| `packages/` | 跨项目复用的共享库（可选） |
| `templates/project-template/` | 新项目脚手架模板 |
| `scripts/` | 工作区脚本（新建项目、状态汇总、CI） |
| `docs/` | 跨项目文档与约定 |
| `.workspace/` | 本地私有区：`github/` 第三方 clone、`local/`、`scratch/`、`archive/`（不公开） |

## 快速开始

```sh
./scripts/new-project.sh <name>   # 新建项目 -> projects/<name>/
./scripts/ci-project.sh <name>    # 运行单个项目的 ci.sh
./scripts/status-all.sh           # 汇总各项目改动
./scripts/update-all.sh           # 拉取根仓库与外部 clone
./scripts/clone.sh <owner>/<repo> # 第三方仓库 -> .workspace/github/
```

## 项目索引

> 新增项目后请在此登记。

| 项目 | 用途 | 状态 | 入口 |
| --- | --- | --- | --- |
| `xhs-content` | 小红书内容助手：飞书审批控制 + OpenCode 智能体 + xhs-kit/Playwright 交付，只产出“发布就绪/草稿”，绝不自动发布 | Phase 0–5 完成，AC-5/AC-6 实测通过（AC-2 待补） | `.workspace/local/xhs-content/`（本地私有工作区，未纳入本仓库跟踪） |

### xhs-content（小红书内容助手）

- 定位：把「生成 → 合规校验 → 人工审批 → 存草稿」做成可控链路，终点是“发布就绪包/草稿”，发布由人完成。
- 分层：
  - 控制层：飞书长连接接收指令与审批回调（手机即可下发/确认）。
  - 智能体层：OpenCode + `git worktree` 隔离工作区，护栏只允许写 `output/`。
  - 交付层：`xhs-kit debug-publish` 只读校验；`Playwright` 无头填表，草稿落浏览器本地 `IndexedDB`。
- 安全：只读环境、命令白名单、`publish` 拦截、CI 全量测试、人工审批（不自动发布、不自动 commit）。
- 说明：该项目位于 `.workspace/` 私有区，因含真实飞书凭据与本地浏览器登录态，不进入本公开仓库。

## 手机 / 飞书

- 浏览仓库、提 Issue、审 PR：GitHub App 或手机浏览器，把仓库链接发到飞书即可。
- 手机端提新项目/需求：用 `.github/ISSUE_TEMPLATE/` 里的模板开 Issue。
- 建目录、跑脚本、构建请在电脑端完成。详见 [docs/workflow.md](docs/workflow.md)。
