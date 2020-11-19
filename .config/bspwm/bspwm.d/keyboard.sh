#!/usr/bin/env bash
set -euo pipefail

function main {
    setxkbmap us dvorak -option caps:ctrl_modifier
}

main "$@"
