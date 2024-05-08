#!/bin/bash
  
  apt_programs=(
    #gcc
    net-tools
  )

  snap_programs=(
    "anki-ppd"
    #"buka"
    #"deckboard"
    "discord"
    "docker"
    "fast"
    "htop"
    "insomnia"
    "libreoffice"
    #"ludo"
    "mailspring"
    "nordpass"
    #"notepadqq"
    #"notes"
    "notion-snap-reborn"
    "notion-calendar-snap"
    "obs-studio"
    "postman"
    #"ppsspp-emu"
    #"slack-term"
    #"slack"
    "spotify"
    #"telegram-cli"
    #"telegram-desktop"
    #"termius-app"
    #"typora"
    #"vestin"
    #"weka"
    "xmind"
  )

  echo "Updating repositories..."
  sudo apt update -y

  echo "Installing APT packages..."
  for apt_program in "${apt_programs[@]}"; do
    sudo apt install "$apt_program" -y
  done
  
  snap refresh

  echo "Installing SNAP packages..."
  sudo snap install android-studio --classic
  sudo snap install clion --classic
  sudo snap install code --classic
  sudo snap install datagrip --classic
  sudo snap install eclipse --classic
  sudo snap install intellij-idea-ultimate --classic
  sudo snap install netbeans --classic
  sudo snap install phpstorm --classic
  sudo snap install pycharm-professional --classic
  sudo snap install sublime-merge --classic
  sudo snap install sublime-text --classic
  sudo snap install webstorm --classic
  
  for snap_program in "${snap_programs[@]}"; do
    sudo snap install "$snap_program"
  done
  
  snap connect nordpass:password-manager-service

  echo "Updating repositories..."
  sudo apt update -y

  echo "Installing Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i ./google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb

  echo "Configuring Docker to work without sudo permission..."
  sudo addgroup --system docker
  sudo adduser $USER docker
  newgrp docker
  sudo snap disable docker
  sudo snap enable docker
  
  echo "Finalizing, updating and cleaning "
  sudo apt update -y
  sudo apt dist-upgrade -y
  sudo apt autoclean -y
  sudo apt autoremove -y

  echo "Process finished, press enter..."
  read enter

  read -p "Do you want to restart your computer now? [Y/N]: " option
  if [ "$option" == "y" ] || [ "$option" == "Y" ]; then
    sudo reboot
  fi

  exit 0
