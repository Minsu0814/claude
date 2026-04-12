# Claude Plugin Store

플러그인들을 모아두는 폴더. 각 하위 폴더가 하나의 플러그인.

## 구조

```
claude-plugin/
  install.sh              ← 모든 플러그인을 순회하며 설치
  example-lsp/
    install.sh            ← 이 플러그인의 설치 스크립트
    plugin.json           ← 플러그인 메타데이터 (선택)
```

## 플러그인 install.sh가 할 수 있는 것

- npm/pip 모듈 설치
- settings.json에 MCP 서버, 퍼미션 등 등록
- commands/, skills/ 심볼릭 링크
- LSP 서버 설정

## 새 플러그인 추가

1. `claude-plugin/my-plugin/` 폴더 생성
2. `install.sh` 작성
3. `/plugin-install` 실행 → 자동 발견·설치
