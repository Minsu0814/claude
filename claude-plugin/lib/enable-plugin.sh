#!/bin/bash
# settings.json의 enabledPlugins에 플러그인을 등록하는 헬퍼
# 사용법: bash enable-plugin.sh <plugin-id> [settings.json 경로]
#   예: bash enable-plugin.sh "playwright@claude-plugins-official"

PLUGIN_ID="$1"
SETTINGS="${2:-$HOME/.claude/settings.json}"

if [ -z "$PLUGIN_ID" ]; then
  echo "[error] 플러그인 ID를 지정하세요"
  exit 1
fi

if [ ! -f "$SETTINGS" ]; then
  echo "[error] $SETTINGS 파일이 없습니다"
  exit 1
fi

# 환경변수로 넘겨서 Windows 경로 문제 회피
PLUGIN_SETTINGS="$SETTINGS" PLUGIN_NAME="$PLUGIN_ID" node -e '
const fs = require("fs");
const settingsPath = process.env.PLUGIN_SETTINGS;
const id = process.env.PLUGIN_NAME;
const data = JSON.parse(fs.readFileSync(settingsPath, "utf8"));
if (!data.enabledPlugins) data.enabledPlugins = {};
if (data.enabledPlugins[id]) {
  console.log("[skip] " + id + " 이미 등록됨");
} else {
  data.enabledPlugins[id] = true;
  fs.writeFileSync(settingsPath, JSON.stringify(data, null, 2) + "\n");
  console.log("[done] " + id + " → settings.json에 등록");
}
'
