#!/usr/bin/env bash
set -euo pipefail

DPPATH=/sys/class/drm/card0-DP-1/status
function isDPConnected {
	[[ $(cat "${DPPATH}") == "connected" ]]
}

function setupWorkspaces {
	if [[ $(hostnamectl --static) == "Titanic" ]]; then
		if isDPConnected; then
			bspc monitor "DP-1" -d I II III IV V
			bspc monitor "eDP-1" -d VI VII VIII IX X
		else
			bspc monitor "eDP-1" -d I II III IV V VI VII VIII IIX IX X
		fi
	else
		bspc monitor "DP-4" -d I II III IV V VI VII
		bspc monitor "HDMI-0" -d VIII IX X
	fi
}

function setupMonitors {
	if [[ $(hostnamectl --transient) == "Titanic" ]]; then
		xrandr --output "eDP-1" --mode 3840x2160 --primary
		if isDPConnected; then
			xrandr --output "DP-1" --mode 3840x2160 --right-of "eDP-1"
		fi
	fi
}

function main {
	setupMonitors
	setupWorkspaces
}

main "$@"
