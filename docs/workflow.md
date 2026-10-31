# Workflow

## 电脑端：创建新项目

```sh
cd agent-repos
git switch main && git pull --ff-only
./scripts/new-project.sh my-agent
cd projects/my-agent
# 编辑 README.md / AGENTS.md / ci.sh / src
```

提交走 PR：

```sh
cd /path/to/agent-repos
git switch -c feat/my-agent/init
git add projects/my-agent
git commit -m "feat(my-agent): 初始化项目"
git push -u origin HEAD
# 按终端提示打开 PR 链接
```

## 电脑端：已有项目加需求

```sh
git switch main && git pull --ff-only
git switch -c feat/<project>/<slug>
# 只改 projects/<project>/
./scripts/ci-project.sh <project>
git add projects/<project>
git commit -m "feat(<project>): <描述>"
git push -u origin HEAD
```

## 手机 / 飞书

手机上不适合跑脚本或写代码，但适合"提需求 + 审核"：

1. 在手机 GitHub App 或浏览器打开仓库。
2. Issues → New issue → 选择「新项目」或「功能需求」模板，填目标与验收标准。
3. 电脑端开工前先看对应 Issue，完成后在 PR 里 `Closes #<编号>`。
4. 收到 PR 通知后，在手机上查看 diff 并审核/合并。
5. 把仓库或 PR 链接直接发到飞书群，便于讨论。

### 飞书通知（可选）

两种方式二选一：

- 飞书自带的 GitHub 集成：授权后订阅本仓库事件。
- 自定义机器人：在飞书群添加机器人拿到 Webhook，存到仓库 Secrets 的 `FEISHU_WEBHOOK`，再启用 `.github/workflows/notify-feishu.yml`。

> 公开仓库不要将 webhook、token 写入代码或提交历史。

## opencode 快捷命令

仓库内置两个自定义命令（`.opencode/command/`）：

- `/new-project <name> <需求描述>`：读取约定 → 建分支 → 脚手架 → 分析 → 实现 → 验证 → 停在审核点。
- `/dev <project> <需求描述>`：为已有项目开发需求，同样停在审核点。

新增或修改命令后需要**重启 opencode** 才会加载。
