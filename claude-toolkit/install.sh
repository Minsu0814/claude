#!/bin/bash
# Claude Toolkit Installer
# commands + skills를 심볼릭 링크로 연결
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
mkdir -p "$CLAUDE_DIR"

# commands 링크 (개별 파일 단위)
mkdir -p "$CLAUDE_DIR/commands"
for cmd in "$SCRIPT_DIR/commands"/*.md; do
  [ -f "$cmd" ] || continue
  name=$(basename "$cmd")
  target="$CLAUDE_DIR/commands/$name"
  if [ -L "$target" ] || [ -f "$target" ]; then
    echo "[skip] commands/$name 이미 존재"
  else
    ln -s "$cmd" "$target"
    echo "[done] commands/$name → $target"
  fi
done

# skills 링크
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  target="$CLAUDE_DIR/skills/$skill_name"
  if [ -d "$target" ]; then
    echo "[skip] skills/$skill_name 이미 존재"
  else
    mkdir -p "$CLAUDE_DIR/skills"
    ln -s "$skill_dir" "$target"
    echo "[done] skills/$skill_name → $CLAUDE_DIR/skills/$skill_name"
  fi
done

echo "=== 설치 완료 ($MODE) ==="
