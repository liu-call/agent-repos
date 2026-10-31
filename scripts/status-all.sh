#!/usr/bin/env bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "== 根仓库 =="
if git -C "$ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git -C "$ROOT" status -sb
else
  echo "（根目录不是 git 仓库）"
fi

echo
echo "== 项目改动 =="
count=0
for dir in "$ROOT"/projects/*/; do
  [ -d "$dir" ] || continue
  name="$(basename "$dir")"
  count=$((count + 1))
  changes="$(git -C "$ROOT" status --porcelain -- "projects/$name" 2>/dev/null | wc -l | tr -d ' ')"
  if [ "$changes" = "0" ]; then
    echo "[clean]  projects/$name"
  else
    echo "[dirty]  projects/$name  ($changes 处改动)"
  fi
done
echo "共 $count 个项目。"

echo
echo "== 外部 clone（.workspace/github） =="
ext=0
for dir in "$ROOT"/.workspace/github/*/*/; do
  [ -d "$dir/.git" ] || continue
  ext=$((ext + 1))
  name="${dir#"$ROOT"/}"
  branch="$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')"
  changes="$(git -C "$dir" status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
  if [ "$changes" = "0" ]; then
    echo "[clean]  $name  ($branch)"
  else
    echo "[dirty]  $name  ($branch, $changes 处改动)"
  fi
done
echo "共 $ext 个外部仓库。"
