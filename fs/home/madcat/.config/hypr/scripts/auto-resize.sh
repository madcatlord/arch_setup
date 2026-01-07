#!/usr/bin/env bash


# window geometry
win=$(hyprctl -j activewindow)
wn=$(echo "$win" | jq '.title')
wx=$(echo "$win" | jq '.at[0]')
wy=$(echo "$win" | jq '.at[1]')
ww=$(echo "$win" | jq '.size[0]')
wh=$(echo "$win" | jq '.size[1]')

# monitor geometry
mon=$(hyprctl -j monitors | jq '.[] | select(.focused)')
mx=$(echo "$mon" | jq '.x')
my=$(echo "$mon" | jq '.y')
# NOTE: We divide with scale here, because apparently the window size is not adjusted to scale
mw=$(echo "$mon" | jq '(.width / .scale) | floor')
mh=$(echo "$mon" | jq '(.height / .scale) | floor')


# echo -e "RAW (Window):\n$win\n\nRAW (Monitor):\n$mon" > ~/.config/hypr/scripts/logs
# echo -e "Window:\nName: $wn\nY: $wy, Height: $wh\n\nMonitor:\nY: $my, Height: $mh" >> ~/.config/hypr/scripts/logs

### Fix too large window
nWidth=$ww
nHeight=$wh

if ((wx < mx || wx + ww > mx + mw)); then
  nWidth="90%"
fi

if ((wy < my || wy + wh > my + mh)); then
  nHeight="90%"
fi



# FIX: This does not work as it should. The window resizes itself for some reason
# hyprctl dispatch setfloating active
# hyprctl dispatch resizeactive exact "$nWidth" "$nHeight"
# hyprctl dispatch centerwindow
  
