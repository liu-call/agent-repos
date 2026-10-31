#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="$ROOT/templates/project-template"

usage() {
  echo "用法: $(basename "$0") <name>" >&2
  echo "name 需为 kebab-case，例如: my-agent" >&2
  exit 1
}

[ $# -eq 1 ] || usage
name="$1"

if ! [[ "$name" =~ ^[a-z][a-z0-9-]*$ ]]; then
  echo "非法项目名: $name（仅允许小写字母/数字/连字符，且以字母开头）" >&2
  exit 1
fi

dest="$ROOT/projects/$name"
if [ -e "$dest" ]; then
  echo "已存在: $dest" >&2
  exit 1
fi

[ -d "$TEMPLATE" ] || { echo "缺少模板: $TEMPLATE" >&2; exit 1; }

mkdir -p "$dest"
cp -R "$TEMPLATE/." "$dest/"

find "$dest" -type f -exec perl -pi -e "s/\{\{PROJECT_NAME\}\}/$name/g" {} +

echo "已创建: projects/$name"
echo
echo "后续步骤:"
echo "  1. 编辑 projects/$name/README.md 与 AGENTS.md"
echo "  2. 在 projects/$name/ci.sh 填入 lint/test 命令"
echo "  3. 在根 README.md 项目索引中登记"
echo "  4. ./scripts/ci-project.sh $name"
