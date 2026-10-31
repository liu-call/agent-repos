#!/usr/bin/env bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  echo "用法: $(basename "$0") <name>" >&2
  exit 1
}

[ $# -eq 1 ] || usage
name="$1"
dir="$ROOT/projects/$name"

[ -d "$dir" ] || { echo "项目不存在: projects/$name" >&2; exit 1; }

if [ -f "$dir/ci.sh" ]; then
  echo "==> projects/$name/ci.sh"
  bash "$dir/ci.sh"
  exit $?
fi

echo "projects/$name 无 ci.sh，跳过。"
