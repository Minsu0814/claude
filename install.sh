#!/bin/bash
# Claude Master Installer
# D:/Folder/claude/ 하위의 모든 컴포넌트(install.sh가 있는 디렉토리)를 자동 발견·설치
# 사용법:
#   bash install.sh           → 전역 설치 (~/.claude/)
#   bash install.sh --local   → 현재 프로젝트에 설치 (./.claude/)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Parse --local flag
LOCAL_FLAG=""
if [ "$1" = "--local" ]; then
  CLAUDE_DIR="./.claude"
  LOCAL_FLAG="--local"
  MODE="프로젝트 로컬"
else
  CLAUDE_DIR="$HOME/.claude"
  MODE="전역"
fi

echo "=== Claude Master Installer ($MODE) ==="

# Discover and run all install.sh files
SUCCEEDED=()
FAILED=()
SKIPPED=()

shopt -s nullglob
for dir in "$SCRIPT_DIR"/*/; do
  name=$(basename "$dir")

  # Skip hidden directories
  [[ "$name" == .* ]] && continue

  install_script="$dir/install.sh"
  if [ ! -f "$install_script" ]; then
    SKIPPED+=("$name")
    continue
  fi

  echo ""
  echo ">>> Installing: $name"
  if bash "$install_script" $LOCAL_FLAG; then
    SUCCEEDED+=("$name")
  else
    FAILED+=("$name")
    echo "[FAIL] $name install.sh 실행 실패"
  fi
done

# Summary
echo ""
echo "=== Install Summary ==="
echo "성공: ${SUCCEEDED[*]:-없음}"
[ ${#FAILED[@]} -gt 0 ] && echo "실패: ${FAILED[*]}"
[ ${#SKIPPED[@]} -gt 0 ] && echo "건너뜀 (install.sh 없음): ${SKIPPED[*]}"
echo "=== 설치 완료 ($MODE) ==="
