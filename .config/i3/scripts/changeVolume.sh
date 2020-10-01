#!/bin/bash
# changeVolume

# Arbitrary but unique message id
msgId="991049"

# Change the volume using alsa(might differ if you use pulseaudio)
pactl set-sink-volume @DEFAULT_SINK@ "$@" && $refresh_i3status

# Query amixer for the current volume and whether or not the speaker is muted
volume=$(pactl list sinks | grep "Volume: front-left" | awk '{printf ("%d", $5)}')
echo $volume;

mute=$(pactl list sinks | grep "Mute" | awk '{print $2}')
if [[ $volume == 0 || "$mute" == "off" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -r "$msgId" \
    "Volume: ${volume}%" "$(./getProgressString 10 "<b> </b>" " " $volume)"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
