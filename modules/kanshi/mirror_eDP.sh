PRIMARY="eDP-1"
EXTERNAL=$(hyprctl monitors | grep 'Monitor' | awk '{print $2}' | grep -v "$PRIMARY" | head -n 1)

if [ -n "$EXTERNAL" ]; then
    hyprctl keyword monitor "$PRIMARY,preferred,0x0,1.25"
    hyprctl keyword monitor "$EXTERNAL,preferred,0x0,1,mirror,$PRIMARY"
fi
