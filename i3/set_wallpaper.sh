#!/usr/bin/env bash

case ${HOSTNAME} in
    archpc)
        feh --bg-max /home/alex/Images/Signal-Iduna-Park-Dortmund-night-lights_1920x1080.jpg
        ;;
    lapsgs24)
        feh --bg-scale ${HOME}/Pictures/wallpaper/minimal-mountain-birds-blue-2560-1440px.jpg
        ;;
    *)
        echo "Current platform is not supported."
        ;;
esac