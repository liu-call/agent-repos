#!/usr/bin/env bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
failed=0

echo "== 根仓库 =="
if git -C "$ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if ! git -C "$ROOT" pull --ff-only; then
    echo "!! 根仓库拉取失败" >&2
    failed=$((failed + 1))
  fi
fi

echo
echo "== 外部 clone（.workspace/github） =="
count=0
for dir in "$ROOT"/.workspace/github/*/*/; do
  [ -d "$dir/.git" ] || continue
  count=$((count + 1))
  name="${dir#"$ROOT"/}"
  echo "==> $name"
  if ! git -C "$dir" pull --ff-only; then
    echo "!! 拉取失败: $name" >&2
    failed=$((failed + 1))
  fi
done

echo "共处理 $count 个外部仓库，失败 $failed 项。"
[ "$failed" -eq 0 ]
