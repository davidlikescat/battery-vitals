# 07_BatteryVitals

## 프로젝트 개요
맥북 배터리 건강(최대 충전 용량 %)·충전 사이클 수·상태(Condition)를 메뉴바에 표시하는 SwiftBar 플러그인. macOS 설정 → 배터리 → 배터리 상태에 안 들어가도 한눈에 확인.

## 기술 스택
- SwiftBar 플러그인 (Bash)
- `system_profiler SPPowerDataType` (건강·사이클·상태)
- `pmset -g batt` (현재 충전·남은 시간·충전 여부)

## 핵심 규칙
- system_profiler는 느리므로 1회만 호출해 변수에 담아 파싱
- 파일명 `battery.5m.sh` = SwiftBar 5분 갱신 주기 (네이밍 규칙)
- 건강%·사이클 임계값으로 색 분기 (양호 초록 / 주의 주황 / 교체 빨강)

## 하지 말 것
- system_profiler를 항목마다 반복 호출 (느림 — 1회 캡처 후 awk 파싱)
- 본업 정보 노출 (이 도구는 개인 맥 정보만)

## 글감 메모
003_macOS 메뉴바 유틸 묶음 글(05 Hydrate · 06 ScreenshotTidy · 07 BatteryVitals) "맥 메뉴바 유틸 3선"의 정보 표시형 파트. 함정 글감: 새로고침 주기 네이밍, 색 분기, system_profiler 성능.
