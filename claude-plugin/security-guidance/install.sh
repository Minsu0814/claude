#!/bin/bash
# Security Guidance Plugin
# 보안 가이드라인을 제공하는 빌트인 플러그인 등록

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LIB_DIR="$(dirname "$SCRIPT_DIR")/lib"

echo "=== Security Guidance Plugin ==="

bash "$LIB_DIR/enable-plugin.sh" "security-guidance@claude-plugins-official"

echo "=== Security Guidance Plugin 완료 ==="
