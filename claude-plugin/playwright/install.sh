#!/bin/bash
# Playwright MCP Plugin
# 브라우저 자동화를 위한 Playwright MCP 서버 설치 + 등록

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LIB_DIR="$(dirname "$SCRIPT_DIR")/lib"

echo "=== Playwright Plugin ==="

# 1. settings.json에 플러그인 등록
bash "$LIB_DIR/enable-plugin.sh" "playwright@claude-plugins-official"

# 2. @playwright/mcp 패키지 확인
if npx @playwright/mcp --help > /dev/null 2>&1; then
  echo "[skip] @playwright/mcp 이미 사용 가능"
else
  echo "[install] @playwright/mcp 설치 중..."
  npm install -g @playwright/mcp@latest
  echo "[done] @playwright/mcp 설치 완료"
fi

echo "=== Playwright Plugin 완료 ==="
