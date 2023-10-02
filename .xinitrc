# Statusbar loop
while true; do
   xsetroot -name "$( date +"%m/%d/%Y %I:%M %p" )"
   sleep 1s    # Update time every second
done &
exec dwm
