echo -ne "
-------------------------------------------------------------------------
 _____                           ___ _           
/__   \___ _ __ ___ ___ _ __    / _ (_)___  ___  
  / /\/ _ \ '__/ __/ _ \ '__|  / /_)/ / __|/ _ \ 
 / / |  __/ | | (_|  __/ |    / ___/| \__ \ (_) |
 \/   \___|_|  \___\___|_|    \/    |_|___/\___/   

-------------------------------------------------------------------------
                    Automated Arch Linux Installer
                       Post-install.sh - 0000101
-------------------------------------------------------------------------
"
mkdir -p /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml
cp ~/TercerPiso/configs/xfce4-keyboard-shortcuts.xml /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
mkdir -p /home/$USERNAME/.config/xfce4/terminal
cp ~/TercerPiso/configs/terminalrc.txt /home/$USERNAME/.config/xfce4/terminal/terminalrc
feh --bg-fill /usr/share/backgrounds/xfce/wallpaper.png