#!/bin/bash
#
# <xbar.title>Battery Vitals</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>AI 코더 랩</xbar.author>
# <xbar.desc>맥북 배터리 건강(최대 충전 용량)·사이클 수·상태를 메뉴바에 표시. 설정에 안 들어가도 한눈에.</xbar.desc>
# <xbar.dependencies>macOS</xbar.dependencies>
#
# 설치: 이 파일을 SwiftBar 플러그인 폴더에 두면 됨. 파일명 'battery.5m.sh' = 5분마다 갱신.
#       chmod +x battery.5m.sh

# 배터리 정보 한 번에 읽어 파싱 (system_profiler는 느려서 1회만 호출)
PWR="$(system_profiler SPPowerDataType 2>/dev/null)"
BATT="$(pmset -g batt 2>/dev/null)"

HEALTH=$(echo "$PWR" | awk -F': ' '/Maximum Capacity/{gsub(/%/,"",$2); print $2; exit}')
CYCLES=$(echo "$PWR" | awk -F': ' '/Cycle Count/{print $2; exit}')
COND=$(echo "$PWR"   | awk -F': ' '/Condition/{print $2; exit}')
SOC=$(echo "$BATT"   | grep -Eo '[0-9]+%' | head -1 | tr -d '%')
REMAIN=$(echo "$BATT" | grep -Eo '[0-9]+:[0-9]+ remaining' | head -1 | sed 's/ remaining//')

# 충전 상태
if echo "$BATT" | grep -q "AC Power"; then
  STATE="충전 중"; PLUG="🔌"
else
  STATE="방전 중"; PLUG="🔋"
fi

# 건강% 색 분기 (글감 포인트: 임계값으로 색을 바꾼다)
HCOLOR="#34c759"                                  # 초록(양호)
[ -n "$HEALTH" ] && [ "$HEALTH" -lt 90 ] && HCOLOR="#ff9f0a"   # 주황(주의)
[ -n "$HEALTH" ] && [ "$HEALTH" -lt 80 ] && HCOLOR="#ff3b30"   # 빨강(교체 고려)

# 사이클 색 분기 (맥북 수명 기준 약 1000회)
CCOLOR="#8e8e93"
[ -n "$CYCLES" ] && [ "$CYCLES" -ge 800 ] && CCOLOR="#ff9f0a"
[ -n "$CYCLES" ] && [ "$CYCLES" -ge 1000 ] && CCOLOR="#ff3b30"

# ── 메뉴바 한 줄 ──
echo "${PLUG} ${SOC}% · ${HEALTH}% | size=13"

# ── 드롭다운 ──
echo "---"
echo "배터리 건강(최대 용량): ${HEALTH}% | color=${HCOLOR}"
echo "충전 사이클: ${CYCLES}회 | color=${CCOLOR}"
echo "상태: ${COND}"
echo "현재 충전: ${SOC}% (${STATE})"
[ -n "$REMAIN" ] && echo "남은 시간: ${REMAIN}"
echo "---"
echo "배터리 설정 열기 | bash='/usr/bin/open' param1='x-apple.systempreferences:com.apple.preference.battery' terminal=false"
echo "새로고침 | refresh=true"
