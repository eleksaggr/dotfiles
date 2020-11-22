#!/usr/bin/env bash
set -euo pipefail

function main {
    bspc monitor "DP-4" -d I II III IV V VI VII
    bspc monitor "HDMI-0" -d VIII IX X

    if [ "$(bspc query --monitors | wc -l)" -gt 2 ]; then
        bspc monitor "DP-3" -d External
    fi
}

main "$@"
