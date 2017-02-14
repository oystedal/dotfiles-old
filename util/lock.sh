#! /bin/bash

bash /home/maestro/.i3/wallpaper/rotate_lockpaper.sh
wp=`head -n1 /home/maestro/.i3/wallpaper/lockpapers`
echo "/home/maestro/.i3/wallpaper/$wp"
i3lock -i /home/maestro/.i3/wallpaper/$wp
systemctl suspend
