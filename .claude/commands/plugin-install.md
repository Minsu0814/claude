현재 작업 디렉토리에서 드라이브 문자를 자동 감지하여 `{드라이브}:/Folder/claude/` 하위의 모든 컴포넌트를 자동으로 발견하고 설치하라.

## 드라이브 감지
- `pwd` 또는 현재 작업 디렉토리 경로에서 드라이브 문자를 추출 (예: C, D)
- 감지된 드라이브로 `{DRIVE}:/Folder/claude/` 경로를 결정

## 동작
- `{DRIVE}:/Folder/claude/*/install.sh`가 있는 모든 디렉토리를 자동 발견
- 각 install.sh를 순서대로 실행
- 최종 요약 (성공/실패/건너뜀) 출력

## 실행 방법
1. `bash {DRIVE}:/Folder/claude/install.sh` 실행 (전역 설치)
2. 사용자가 `--local`을 인자로 전달하면 `bash {DRIVE}:/Folder/claude/install.sh --local` 실행

## 옵션
- 사용자가 `--local`을 인자로 전달하면 현재 프로젝트(.claude/)에 설치
- 인자 없으면 전역(~/.claude/) 설치
