D:/Folder/claude/ 하위의 모든 컴포넌트를 자동으로 발견하고 설치하라.

## 동작
- `D:/Folder/claude/*/install.sh`가 있는 모든 디렉토리를 자동 발견
- 각 install.sh를 순서대로 실행
- 최종 요약 (성공/실패/건너뜀) 출력

## 실행 방법
1. `bash D:/Folder/claude/install.sh` 실행 (전역 설치)
2. 사용자가 `--local`을 인자로 전달하면 `bash D:/Folder/claude/install.sh --local` 실행

## 옵션
- 사용자가 `--local`을 인자로 전달하면 현재 프로젝트(.claude/)에 설치
- 인자 없으면 전역(~/.claude/) 설치
