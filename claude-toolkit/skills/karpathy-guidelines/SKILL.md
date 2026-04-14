---
name: karpathy-guidelines
description: Andrej Karpathy의 LLM 코딩 가이드라인. 코드 작성 시 4가지 핵심 원칙 적용.
disable-model-invocation: false
allowed-tools: Read, Grep, Glob, Edit, Write, Bash
---

# Karpathy LLM Coding Guidelines

Andrej Karpathy의 LLM 코딩 원칙을 현재 작업에 적용해요.

## 4가지 핵심 원칙

### 1. Think Before Coding (코드 전에 생각)
- 코드를 쓰기 전에 **무엇을**, **왜** 하는지 명확히 해야 해요
- 변경 범위를 미리 파악하고, 영향받는 파일/모듈을 확인해요
- 복잡한 작업은 먼저 계획을 세우고 시작해요

### 2. Simplicity First (단순함 우선)
- 가장 단순한 해결책부터 시도해요
- 불필요한 추상화, 과도한 엔지니어링을 피해요
- "지금 필요한 것"만 구현해요 (YAGNI)
- 코드 줄 수를 늘리는 것보다 줄이는 것이 더 가치 있어요

### 3. Surgical Changes (외과적 변경)
- 변경은 최소한으로, 정확하게 해요
- 관련 없는 코드를 건드리지 않아요
- 하나의 커밋 = 하나의 논리적 변경
- 리팩토링과 기능 추가를 섞지 않아요

### 4. Goal-Driven Execution (목표 중심 실행)
- 항상 "이 변경이 목표에 기여하는가?"를 자문해요
- 토끼굴에 빠지지 않아요 — 옆길로 새면 즉시 멈추고 돌아와요
- 완료 기준을 명확히 하고, 달성하면 멈춰요

## 적용 방법

이 스킬이 호출되면:
1. 현재 작업 내용을 확인해요
2. 4가지 원칙 관점에서 접근 방식을 점검해요
3. 원칙에 어긋나는 부분이 있으면 개선안을 제시해요

## Credits

Based on [Andrej Karpathy's LLM coding guidelines](https://github.com/forrestchang/andrej-karpathy-skills). MIT License.
