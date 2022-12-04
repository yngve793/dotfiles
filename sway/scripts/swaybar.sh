#!/usr/bin/env bash

# Change this according to your device
################
# Variables
################

# Keyboard input name
#keyboard_input_name="9494:33:CM_Storm_Keyboard_--_Trigger_Z_gaming"

# Date and time
date_and_week=$(date "+%Y-%m-%d")
current_time=$(date "+%H:%M")

#############
# Commands
#############

# Battery or charger
#battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
#battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

# Audio and multimedia
audio_volume=$(pamixer --sink "$(pactl list sinks short | grep RUNNING | awk '{print $1}')" --get-volume)
audio_is_muted=$(pamixer --sink "$(pactl list sinks short | grep RUNNING | awk '{print $1}')" --get-mute)
#media_artist=$(playerctl metadata artist)
#media_song=$(playerctl metadata title)
#player_status=$(playerctl status)

# Network
#network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
network=eno1
# interface_easyname grabs the "old" interface name before systemd renamed it
#interface_easyname=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
interface_easyname=${network}
ip_address=$(ip -o -4 addr list ${network} | awk '{print $4}' | cut -d'/' -f1)
#ping=$(ping -c 1 www.google.es | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

# Others
#language=$(swaymsg -r -t get_inputs | awk '/${keyboard_input_name}/;/xkb_active_layout_name/' | grep -A1 '\${keyboard_input_name}\' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}' | tail -n1 )
#language=$(swaymsg -r -t get_inputs  | awk '/9494:33:CM_Storm_Keyboard_--_Trigger_Z_gaming/;/xkb_active_layout_name/' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}' | tail -n1)
#language=$(swaymsg -t get_inputs | jq '.[9].xkb_active_layout_name' | cut -d"/" )
language=$(swaymsg -t get_inputs | jq '.[9].xkb_active_layout_name' | tr -d '"' | cut -d' ' -f1)
#loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')
loadavg_5min=$(awk -F ' ' '{print $2}' </proc/loadavg)

# Removed weather because we are requesting it too many times to have a proper
# refresh on the bar
#weather=$(curl -Ss 'https://wttr.in/Pontevedra?0&T&Q&format=1')

#if ! [ "$network" ]; then
#network_active="offline"
#else
if [ "$network" ]; then
	#   network_active="⇆"
	#   network_speed=`ethtool eno1 | grep -i speed | cut -d':' -f2 | cut -d' ' -f2`
	network_speed=$(cat /sys/class/net/eno1/speed)
fi

#if [ $player_status = "Playing" ]
#then
#    song_status='▶'
#elif [ $player_status = "Paused" ]
#then
#    song_status='⏸'
#else
#    song_status='⏹'
#fi

if [ "$audio_is_muted" = "true" ]; then
	audio_active='muted'
else
	audio_active='Vol'
fi

disk_space_root=$(df -h --output=avail / | tail -n1 | tr -d ' ')

#echo $language
echo "| $language | / ${disk_space_root} | $interface_easyname: ${ip_address} ($network_speed MBit/s) | load $loadavg_5min | $audio_active $audio_volume% | $date_and_week $current_time"
