date_formatted=$(date "+%a %x %H:%M")
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

echo 🔋 $battery_capacity \($battery_status\) 🕓 $date_formatted
