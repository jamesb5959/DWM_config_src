# Statusbar loop
while true; do
   xsetroot -name "$( date +"%F %R" )"
   sleep 1s    # Update time every minute
done &
exec dwm
