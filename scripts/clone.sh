#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GITHUB_DIR="$ROOT/.workspace/github"

usage() {
  echo "用法: $(basename "$0") <owner>/<repo> [git clone 额外参数]" >&2
  echo "示例: $(basename "$0") vercel/next.js" >&2
  exit 1
}

[ $# -ge 1 ] || usage

slug="$1"
shift
case "$slug" in
  */*) ;;
  *) usage ;;
esac

owner="${slug%%/*}"
repo="${slug##*/}"
dest="$GITHUB_DIR/$owner/$repo"

if [ -e "$dest" ]; then
  echo "已存在: $dest" >&2
  exit 1
fi

mkdir -p "$(dirname "$dest")"

if command -v gh >/dev/null 2>&1; then
  echo "==> gh repo clone $slug -> $dest"
  gh repo clone "$slug" "$dest" -- "$@"
else
  url="https://github.com/$slug.git"
  echo "==> git clone $url -> $dest"
  git clone "$url" "$dest" "$@"
fi

echo "完成: $dest"
