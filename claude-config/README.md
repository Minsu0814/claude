# Claude Config

Claude Code 전역 설정 관리.

## 구조

```
settings.json   — 전역 설정 (모델, 권한, 훅, env)
install.sh      — 심볼릭 링크로 ~/.claude/에 연결
```

> agents는 프로젝트마다 다르므로 각 프로젝트의 `.claude/agents/`에서 관리

## 설치

```bash
git clone https://github.com/Minsu0814/claude-config.git
cd claude-config
bash install.sh
```

## 포함된 설정

- **모델**: Opus
- **권한**: Read/Edit 전체 허용, rm -rf / .env 차단
- **훅**: Windows 토스트 알림
