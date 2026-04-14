---
name: init-project
description: 새 프로젝트 초기 세팅. notes 디렉토리 + Hooks(.env 보호, 토스트 알림, Prettier) + 권한 설정 + CLAUDE.md 기본 규칙 자동 생성.
argument-hint: [project-name]
disable-model-invocation: true
allowed-tools: Bash, Read, Write, Edit, Glob
---

# 프로젝트 초기 세팅

새 프로젝트에 표준 세팅을 자동으로 적용해요.

## 실행 내용

### 1. notes/ 디렉토리 생성
- 프로젝트 루트에 `notes/` 디렉토리 생성
- `notes/.gitkeep` 파일 생성 (빈 디렉토리 git 추적용)

### 2. .claude/settings.json 세팅
- `.claude/` 디렉토리 없으면 생성
- `settings.json`에 아래 내용 추가 (기존 내용 보존):
  - `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS: "1"` (에이전트 팀 활성화)
  - **PreToolUse Hook**: `.env` 파일 접근 차단
  - **PostToolUse Hook**: Edit|Write 시 Prettier 자동 포맷
  - **Notification Hook**: Windows PowerShell 토스트 알림
  - **permissions.deny**: `Bash(rm -rf*)`, `Edit(.env*)` 차단
- 이미 존재하면 hooks 부분만 병합

hooks 설정 상세:
```json
"PreToolUse": [{
  "matcher": "Edit|Write|Bash",
  "hooks": [{
    "type": "command",
    "command": "echo \"$FILE_PATH $INPUT\" | grep -qi '\\.env' && echo 'BLOCKED: .env 파일 접근 차단됨' && exit 1 || true"
  }]
}],
"PostToolUse": [{
  "matcher": "Edit|Write",
  "hooks": [{
    "type": "command",
    "command": "npx prettier --write \"$FILE_PATH\" 2>/dev/null || true"
  }]
}],
"Notification": [{
  "hooks": [{
    "type": "command",
    "command": "powershell -Command \"[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; $template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent(0); $text = $template.GetElementsByTagName('text'); $text.Item(0).AppendChild($template.CreateTextNode('Claude Code: $TITLE')) | Out-Null; $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Claude Code'); $notifier.Show([Windows.UI.Notifications.ToastNotification]::new($template))\""
  }]
}]
```

### 3. CLAUDE.md 기본 규칙 추가
- CLAUDE.md가 없으면 새로 생성
- 이미 있으면 아래 섹션이 없는 경우에만 추가:

추가할 섹션들:

```markdown
## 원칙
- 한국어 해요체, 코드는 영어
- 3단계 이상 작업 → Plan Mode 필수
- 일이 꼬이면 즉시 멈추고 re-plan
- Git: Conventional commits (feat:, fix:, docs:, refactor:)

## Karpathy 코딩 원칙
- **Think Before Coding**: 코드 전에 무엇을, 왜 하는지 명확히. 복잡하면 계획부터.
- **Simplicity First**: 가장 단순한 해결책 우선. 불필요한 추상화 금지. YAGNI.
- **Surgical Changes**: 최소한의 정확한 변경. 관련 없는 코드 건드리지 않기. 리팩토링과 기능 추가 분리.
- **Goal-Driven Execution**: 목표에 기여하는 변경만. 옆길로 새면 즉시 멈추고 복귀.

## Notes 디렉토리
- 작업/기능마다 `notes/` 디렉토리를 유지할 것
- 작업 중 발견한 내용, 의사결정 이유, 삽질 로그 등을 기록
- PR 올린 후에도 학습 내용이 남도록 `lessons.md` 파일 업데이트 해줘
- 형식: `notes/{작업명}.md`

## 코드 규칙
- 함수 30줄 이내, 파일 300줄 이내
- API 엔드포인트마다 에러 핸들링

## 검증
- 수정 후 관련 테스트 실행
- "시니어 엔지니어가 승인할까?" 기준

## 교훈 (틀린 것 다시 안 틀리기 위한 카닝)
<!-- 실수할 때마다 여기에 추가. 절대 삭제하지 말 것. -->
```

### 4. 결과 보고
- 생성/수정된 파일 목록 출력
- 이미 존재해서 건너뛴 항목 안내

## 주의사항
- 기존 파일은 절대 덮어쓰지 않음 (없는 부분만 추가)
- settings.json 기존 permissions, env는 보존
- $ARGUMENTS가 있으면 CLAUDE.md 프로젝트 이름으로 사용
