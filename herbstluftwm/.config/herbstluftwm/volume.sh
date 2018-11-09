#!/usr/bin/env bash

function showCurrentVolume {
    amixer sget Master | \
        grep "Front Left:" | \
        awk -F '[][]' '{ print "Volume " $2 }' | \
        dzen2 -p 1
}

case $1 in
    down)
        amixer -q set Master 2%- unmute
        showCurrentVolume
        ;;
    up)
        amixer -q set Master 2%+ unmute
        showCurrentVolume
        ;;
    mute)
        amixer -q set Master mute
        echo "Mute" | dzen2 -p 1
        ;;
esac
