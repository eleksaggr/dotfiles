#!/usr/bin/env bash
set -euo pipefail

function main {
    bspc rule --add "Emacs" state=tiled
}

main
