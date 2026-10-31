# Contributing

## 分支

- 从 `main` 拉出短分支：`feat/<project>/<slug>`、`fix/<project>/<slug>`、`chore/<slug>`。
- 一个分支只做一件事，尽量只涉及一个项目。

## 提交

遵循 Conventional Commits，scope 使用项目名：

```
feat(<project>): 新增 xxx
fix(<project>): 修复 xxx
docs(<project>): 更新文档
chore: 工作区脚本调整
```

## 流程

1. `git switch main && git pull --ff-only`
2. `git switch -c feat/<project>/<slug>`
3. 开发并本地验证：`./scripts/ci-project.sh <project>`
4. `git push -u origin HEAD`，根据终端提示创建 PR
5. PR 审核通过后合并；发布打 tag：`<project>/vX.Y.Z`

## 新项目

```sh
./scripts/new-project.sh <name>
# 补全 projects/<name>/README.md、AGENTS.md、ci.sh
```

## 约定

- 不提交 `.workspace/`、`.env`、密钥、大二进制文件。
- 每个项目自带可执行的 `ci.sh`，CI 会按项目路径触发。
