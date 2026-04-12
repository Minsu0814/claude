#!/bin/bash
# Bin Installer
# 단축키 스크립트를 ~/bin에 심볼릭 링크로 연결
# 사용법: bash install.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/bin"

echo "=== Bin 단축키 설치 ==="
mkdir -p "$TARGET_DIR"

# fzf 설치 (없으면 자동 다운로드)
if [ ! -f "$TARGET_DIR/fzf.exe" ] && [ ! -f "$TARGET_DIR/fzf" ]; then
  echo "[install] fzf 다운로드 중..."
  FZF_VERSION="0.62.0"
  if [[ "$(uname -s)" == *"MINGW"* ]] || [[ "$(uname -s)" == *"MSYS"* ]] || [[ "$OS" == "Windows_NT" ]]; then
    curl -sL "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-windows_amd64.zip" -o "$TARGET_DIR/fzf.zip"
    unzip -o "$TARGET_DIR/fzf.zip" fzf.exe -d "$TARGET_DIR"
    rm -f "$TARGET_DIR/fzf.zip"
  else
    curl -sL "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" -o "$TARGET_DIR/fzf.tar.gz"
    tar -xzf "$TARGET_DIR/fzf.tar.gz" -C "$TARGET_DIR" fzf
    rm -f "$TARGET_DIR/fzf.tar.gz"
  fi
  echo "[done] fzf 설치 완료"
else
  echo "[skip] fzf 이미 존재"
fi

for bat in "$SCRIPT_DIR"/*.bat; do
  [ -f "$bat" ] || continue
  name=$(basename "$bat")
  target="$TARGET_DIR/$name"
  if [ -L "$target" ] || [ -f "$target" ]; then
    echo "[skip] $name 이미 존재"
  else
    ln -s "$bat" "$target"
    echo "[done] $name → $target"
  fi
done

echo "=== 설치 완료 ==="
