#!/usr/bin/env bash
set -euo pipefail

function main {
    xrandr --output "DP-4" --mode 1920x1080 --rate 144.00 --primary
    xrandr --output "HDMI-0" --mode 1920x1080 --rate 60.00 --right-of "DP-4"

    # The default state for the external TV screen is off.
    # Use * and * to enable/disable it.
    xrandr --output "DP-3" --off
}

main "$@"
