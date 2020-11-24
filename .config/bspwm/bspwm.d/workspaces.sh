#!/usr/bin/env bash
set -euo pipefail

function main {
	if [[ $(hostnamectl --static) == "Titanic" ]]; then
		bspc monitor "DP-1" -d I II III IV V
		bspc monitor "eDP-1" -d VI VII VIII IX X
	else
		bspc monitor "DP-4" -d I II III IV V VI VII
		bspc monitor "HDMI-0" -d VIII IX X

		if [ "$(bspc query --monitors | wc -l)" -gt 2 ]; then
			bspc monitor "DP-3" -d External
		fi
	fi
}

main "$@"
