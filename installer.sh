#!/bin/bash
#github-action genshdoc
#
# @file ArchTitus
# @brief Entrance script that launches children scripts for each phase of installation.

# Find the name of the folder the scripts are in
loadkeys es
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
set +a
echo -ne "
-------------------------------------------------------------------------
 _____                           ___ _           
/__   \___ _ __ ___ ___ _ __    / _ (_)___  ___  
  / /\/ _ \ '__/ __/ _ \ '__|  / /_)/ / __|/ _ \ 
 / / |  __/ | | (_|  __/ |    / ___/| \__ \ (_) |
 \/   \___|_|  \___\___|_|    \/    |_|___/\___/ 
                                                 
  ___           _    ______     _ _             
 / _ \         | |   |  _  \   (_) |            
/ /_\ \_ __ ___| |__ | | | |___ _| |_ _ __ ___  
|  _  | '__/ __| '_ \| | | / __| | __| '__/ _ \ 
| | | | | | (__| | | | |/ /\__ \ | |_| | | (_) |
\_| |_/_|  \___|_| |_|___/ |___/_|\__|_|  \___/ 

-------------------------------------------------------------------------
                    Automated Arch Linux Installer
-------------------------------------------------------------------------
                Scripts are in directory named TercerPiso
"
    ( bash $SCRIPT_DIR/scripts/startup.sh )|& tee startup.log
      source $CONFIGS_DIR/setup.conf
    ( bash $SCRIPT_DIR/scripts/0-preinstall.sh )|& tee 0-preinstall.log
    ( arch-chroot /mnt $HOME/TercerPiso/scripts/1-setup.sh )|& tee 1-setup.log
    if [[ ! $DESKTOP_ENV == server ]]; then
      ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/TercerPiso/scripts/2-user.sh )|& tee 2-user.log
    fi
    ( arch-chroot /mnt $HOME/TercerPiso/scripts/3-post-setup.sh )|& tee 3-post-setup.log
    cp -v *.log /mnt/home/$USERNAME

echo -ne "
-------------------------------------------------------------------------
 _____                           ___ _           
/__   \___ _ __ ___ ___ _ __    / _ (_)___  ___  
  / /\/ _ \ '__/ __/ _ \ '__|  / /_)/ / __|/ _ \ 
 / / |  __/ | | (_|  __/ |    / ___/| \__ \ (_) |
 \/   \___|_|  \___\___|_|    \/    |_|___/\___/ 
                                                 
  ___           _    ______     _ _             
 / _ \         | |   |  _  \   (_) |            
/ /_\ \_ __ ___| |__ | | | |___ _| |_ _ __ ___  
|  _  | '__/ __| '_ \| | | / __| | __| '__/ _ \ 
| | | | | | (__| | | | |/ /\__ \ | |_| | | (_) |
\_| |_/_|  \___|_| |_|___/ |___/_|\__|_|  \___/ 

-------------------------------------------------------------------------
                    Automated Arch Linux Installer
-------------------------------------------------------------------------
                Done - Please Eject Install Media and Reboot
"

read -p "Press any key to reboot ..."
reboot