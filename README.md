# BatteryVitals

A [SwiftBar](https://github.com/swiftbar/SwiftBar) plugin that shows your Mac's battery health right in the menu bar — maximum charge capacity (%), cycle count, and condition — without digging into System Settings › Battery › Battery Health.

## What it shows

- Battery health (maximum capacity %)
- Charge cycle count
- Condition (Normal / Service recommended)
- Current charge, time remaining, and whether it's charging

Color-coded by thresholds: green (healthy), orange (watch), red (replace).

## How it works

- `system_profiler SPPowerDataType` for health, cycles, and condition
- `pmset -g batt` for current charge and charging state
- `system_profiler` is slow, so it's called once and parsed, not per field

## Install

1. Install [SwiftBar](https://github.com/swiftbar/SwiftBar)
2. Drop `battery.5m.sh` into your SwiftBar plugins folder

The `5m` in the filename tells SwiftBar to refresh every 5 minutes.

## License

MIT — see [LICENSE](LICENSE).
