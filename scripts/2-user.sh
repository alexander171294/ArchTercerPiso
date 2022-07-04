#!/usr/bin/env bash
#github-action genshdoc
#
# @file User
# @brief User customizations and AUR package installation.
echo -ne "
-------------------------------------------------------------------------
 _____                           ___ _           
/__   \___ _ __ ___ ___ _ __    / _ (_)___  ___  
  / /\/ _ \ '__/ __/ _ \ '__|  / /_)/ / __|/ _ \ 
 / / |  __/ | | (_|  __/ |    / ___/| \__ \ (_) |
 \/   \___|_|  \___\___|_|    \/    |_|___/\___/ 
                                                 
  _   _                   
 | | | |___  ___ _ __ ___ 
 | | | / __|/ _ \ '__/ __|
 | |_| \__ \  __/ |  \__ \
  \___/|___/\___|_|  |___/
                          
-------------------------------------------------------------------------
                    Automated Arch Linux Installer
                          Users.sh - 0000010
-------------------------------------------------------------------------

Installing AUR Softwares
"
source $HOME/TercerPiso/configs/setup.conf

cd ~

  mkdir "/home/$USERNAME/.cache"
  touch "/home/$USERNAME/.cache/zshhistory"

sed -n '/'$INSTALL_TYPE'/q;p' ~/TercerPiso/pkg-files/${DESKTOP_ENV}.txt | while read line
do
  if [[ ${line} == '--END OF MINIMAL INSTALL--' ]]
  then
    # If selected installation type is FULL, skip the --END OF THE MINIMAL INSTALLATION-- line
    continue
  fi
  echo "INSTALLING: ${line}"
  sudo pacman -S --noconfirm --needed ${line}
done


if [[ ! $AUR_HELPER == none ]]; then
  cd ~
  git clone "https://aur.archlinux.org/$AUR_HELPER.git"
  cd ~/$AUR_HELPER
  makepkg -si --noconfirm
  # sed $INSTALL_TYPE is using install type to check for MINIMAL installation, if it's true, stop
  # stop the script and move on, not installing any more packages below that line
  sed -n '/'$INSTALL_TYPE'/q;p' ~/TercerPiso/pkg-files/aur-pkgs.txt | while read line
  do
    if [[ ${line} == '--END OF MINIMAL INSTALL--' ]]; then
      # If selected installation type is FULL, skip the --END OF THE MINIMAL INSTALLATION-- line
      continue
    fi
    echo "INSTALLING: ${line}"
    $AUR_HELPER -S --noconfirm --needed ${line}
  done
fi

export PATH=$PATH:~/.local/bin

# Theming DE if user chose FULL installation
if [[ $INSTALL_TYPE == "FULL" ]]; then
  if [[ $DESKTOP_ENV == "kde" ]]; then
    cp -r ~/TercerPiso/configs/.config/* ~/.config/
    pip install konsave
    konsave -i ~/TercerPiso/configs/kde.knsv
    sleep 1
    konsave -a kde
  elif [[ $DESKTOP_ENV == "openbox" ]]; then
    cd ~
    git clone https://github.com/stojshic/dotfiles-openbox
    ./dotfiles-openbox/install-titus.sh
  fi
fi


  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

pwd

  cp ~/TercerPiso/configs/.zshrc /home/$USERNAME/.zshrc
  sudo mkdir "/usr/share/zsh-sudo/"
  chsh -s $(which zsh)
  sudo cp ~/TercerPiso/configs/sudo.plugin.zsh /usr/share/zsh-sudo/sudo.plugin.zsh
  sudo cp ~/TercerPiso/configs/wallpaper.png /usr/share/backgrounds/xfce/wallpaper.png
  sudo cp ~/TercerPiso/configs/vconsole.conf /etc/vconsole.conf

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit