---
name: commit-push
description: 변경사항 커밋 후 지정한 리모트로 푸시. /commit-push origin 또는 /commit-push <remote-name>
argument-hint: <remote-name>
disable-model-invocation: true
allowed-tools: Bash(git *)
---

# Commit and Push

변경사항을 커밋하고 지정한 리모트로 푸시해요.

## 사용법

`/commit-push <remote-name>`

- 인자로 리모트 이름 전달 (예: `origin`, `upstream`)
- 인자 없으면 `origin`을 기본값으로 사용

## 리모트 확인

`git remote -v`로 현재 프로젝트에 등록된 리모트 목록을 확인하고, 전달받은 이름과 매칭한다.
존재하지 않는 리모트 이름이면 사용자에게 알리고 중단한다.

## 실행 순서

1. `git remote -v`로 등록된 리모트 목록 확인
2. `git status`로 변경사항 확인
3. `git diff --staged`와 `git diff`로 변경 내용 파악
4. `git log --oneline -5`로 최근 커밋 스타일 확인
5. **notes/ 체크**: `notes/` 디렉토리가 존재하면 이번 변경사항에 대한 노트가 있는지 확인
   - 관련 노트가 없으면 `notes/{작업명}.md` 파일을 작성 (작업 내용, 의사결정, 발견사항)
   - 이미 관련 노트가 있으면 변경사항 반영해서 업데이트
   - 노트 파일도 함께 스테이징
6. **CLAUDE.md 체크**: CLAUDE.md가 존재하면 이번 변경사항이 아래 항목에 영향을 주는지 확인
   - **현재 상태**: 체크리스트(✅/❌) 갱신, 완료된 작업 반영
   - **코드 구조**: 새 디렉토리/파일 추가·삭제·이동 시 트리 업데이트
   - **교훈**: 작업 중 삽질이나 주의사항 발견 시 추가 (절대 삭제하지 말 것)
   - 변경 없으면 건너뛰기, 변경 있으면 함께 스테이징
7. 변경사항이 있으면 `git add`로 관련 파일 스테이징 (민감한 파일 .env 등 제외)
8. Conventional commit 형식으로 커밋 메시지 작성 (feat:, fix:, docs:, refactor:)
9. 커밋 메시지 끝에 `Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>` 추가
10. `$ARGUMENTS`로 전달된 리모트 이름 확인:
    - 인자 없으면 `origin`을 기본값으로 사용
    - `git remote -v`에 없는 이름이면 사용자에게 알리고 중단
11. 현재 브랜치로 `git push <remote> <branch>` 실행
12. 결과 보고

## 주의사항

- `.env`, credentials 등 민감한 파일은 절대 커밋하지 않음
- 푸시 전에 커밋 내용을 사용자에게 보여주고 확인
- force push는 절대 하지 않음
