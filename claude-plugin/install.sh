#!/bin/bash
# Claude Plugin Store Installer
# claude-plugin/ 하위의 모든 플러그인을 발견하고 설치
# 각 플러그인은 자체 install.sh로 모듈 설치, settings.json 등록, 심볼릭 링크 등을 처리
# 사용법:
#   bash install.sh           → 전역 설치 (~/.claude/)
#   bash install.sh --local   → 현재 프로젝트에 설치 (./.claude/)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

LOCAL_FLAG=""
if [ "$1" = "--local" ]; then
  CLAUDE_DIR="./.claude"
  LOCAL_FLAG="--local"
  MODE="프로젝트 로컬"
else
  CLAUDE_DIR="$HOME/.claude"
  MODE="전역"
fi

echo "=== Claude Plugin Store ($MODE) ==="

SUCCEEDED=()
FAILED=()
SKIPPED=()

shopt -s nullglob
for dir in "$SCRIPT_DIR"/*/; do
  plugin_name=$(basename "$dir")

  # Skip hidden directories
  [[ "$plugin_name" == .* ]] && continue

  install_script="$dir/install.sh"
  if [ ! -f "$install_script" ]; then
    SKIPPED+=("$plugin_name")
    continue
  fi

  echo ""
  echo ">>> Plugin: $plugin_name"
  if bash "$install_script" $LOCAL_FLAG; then
    SUCCEEDED+=("$plugin_name")
  else
    FAILED+=("$plugin_name")
    echo "[FAIL] $plugin_name 설치 실패"
  fi
done

if [ ${#SUCCEEDED[@]} -eq 0 ] && [ ${#FAILED[@]} -eq 0 ]; then
  echo "(설치할 플러그인 없음)"
fi

echo ""
echo "=== Plugin Store Summary ==="
[ ${#SUCCEEDED[@]} -gt 0 ] && echo "성공: ${SUCCEEDED[*]}"
[ ${#FAILED[@]} -gt 0 ] && echo "실패: ${FAILED[*]}"
[ ${#SKIPPED[@]} -gt 0 ] && echo "건너뜀: ${SKIPPED[*]}"
echo "=== 완료 ==="
