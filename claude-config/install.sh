#!/bin/bash
# Claude Config Installer
# 전역 settings.json을 ~/.claude/에 심볼릭 링크로 연결

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== Claude Config 설치 ==="

# settings.json 링크
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "[skip] ~/.claude/settings.json 이미 존재 — 수동으로 병합하세요"
else
  ln -s "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
  echo "[done] settings.json → ~/.claude/settings.json"
fi

echo "=== 설치 완료 ==="
