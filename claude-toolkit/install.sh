#!/bin/bash
# Claude Toolkit Installer
# commands + skills를 대상 디렉토리로 복사
# 사용법:
#   bash install.sh           → 전역 설치 (~/.claude/)
#   bash install.sh --local   → 현재 프로젝트에 설치 (./.claude/)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$1" = "--local" ]; then
  CLAUDE_DIR="./.claude"
  MODE="프로젝트 로컬"
else
  CLAUDE_DIR="$HOME/.claude"
  MODE="전역"
fi

echo "=== Claude Toolkit 설치 ($MODE) ==="
mkdir -p "$CLAUDE_DIR/commands" "$CLAUDE_DIR/skills"

# commands 복사 (개별 파일 단위, 항상 덮어쓰기)
for cmd in "$SCRIPT_DIR/commands"/*.md; do
  [ -f "$cmd" ] || continue
  name=$(basename "$cmd")
  cp -f "$cmd" "$CLAUDE_DIR/commands/$name"
  echo "[done] commands/$name"
done

# skills 복사 (디렉토리 단위, 기존 junction/symlink 제거 후 복사)
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  target="$CLAUDE_DIR/skills/$skill_name"
  [ -e "$target" ] || [ -L "$target" ] && rm -rf "$target"
  cp -r "$skill_dir" "$target"
  echo "[done] skills/$skill_name"
done

echo "=== 설치 완료 ($MODE) ==="
