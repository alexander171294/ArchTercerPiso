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
mkdir -p $HOME/.config/xfce4/xfconf/xfce-perchannel-xml
cp ~/TercerPiso/configs/xconf/xfce4-keyboard-shortcuts.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
cp ~/TercerPiso/configs/xconf/xfce4-panel.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
cp ~/TercerPiso/configs/xconf/keyboard-layout.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/keyboard-layout.xml
cp ~/TercerPiso/configs/xconf/xfce4-power-manager.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
cp ~/TercerPiso/configs/xconf/xfwm4.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
cp ~/TercerPiso/configs/xconf/xsettings.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
mkdir -p $HOME/.config/xfce4/terminal
cp ~/TercerPiso/configs/terminalrc.txt $HOME/.config/xfce4/terminal/terminalrc
feh --bg-fill /usr/share/backgrounds/xfce/wallpaper.png
cd Qogir
./install.sh --tweaks round
cd ../Qogir-icon
./install.sh
cd ..
cp -R fonts $HOME/.local/share