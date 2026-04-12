#!/bin/bash
# LSP Plugins - TypeScript, Rust, Python, Java
# settings.json에 LSP 플러그인들을 등록

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LIB_DIR="$(dirname "$SCRIPT_DIR")/lib"

echo "=== LSP Plugins ==="

PLUGINS=(
  "typescript-lsp@claude-plugins-official"
  "rust-analyzer-lsp@claude-plugins-official"
  "pyright-lsp@claude-plugins-official"
  "jdtls-lsp@claude-plugins-official"
)

for plugin in "${PLUGINS[@]}"; do
  bash "$LIB_DIR/enable-plugin.sh" "$plugin"
done

echo "=== LSP Plugins 완료 ==="
