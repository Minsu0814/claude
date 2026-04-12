# Claude Toolkit

Claude Code에서 사용하는 커맨드 + 스킬 모음.

## 구조

```
commands/
  commit.md     — 변경사항 분석 → 한국어 커밋 → push
  review.md     — 시니어 엔지니어 관점 코드 리뷰
  blog.md       — SEO 키워드 추출 → 블로그 글 작성
  fix.md        — 에러 분석 → 수정 → 교훈 기록
  start.md      — 새 작업 세션 시작 체크리스트
skills/
  init-project/ — 프로젝트 초기 세팅 (hooks, CLAUDE.md, notes/)
  commit-push/  — 커밋 + 푸시 자동화
```

## 설치

```bash
git clone https://github.com/Minsu0814/claude-toolkit.git
cd claude-toolkit
bash install.sh
```

## 사용법

Claude Code에서 슬래시 커맨드로 호출:

```
/commit          — 커밋 + 푸시
/review          — 코드 리뷰
/blog GTX 분석   — 블로그 글 작성
/fix TypeError   — 에러 수정
/start 리팩토링  — 작업 세션 시작
/init-project    — 프로젝트 초기 세팅
```
