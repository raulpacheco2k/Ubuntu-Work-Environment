#!/bin/bash

  sudo add-apt-repository universe -y
  sudo add-apt-repository ppa:agornostal/ulauncher -y

  echo "Updating repositories..."
  sudo apt update -y

  gsettings set org.gnome.desktop.interface enable-animations false
  gsettings set org.gnome.nautilus.preferences default-sort-order 'type'
  
  apt_programs=(
    curl
    neofetch
    net-tools
    prelink
    preload
    tree
    ulauncher
  )

  snap_programs=(
    # Development
    "docker"
    "postman"
    "insomnia"
    "termius-app"

    # Utilities
    "btop"
    "nordpass"
    "libreoffice"
    "thunderbird"
    "fast"

    # Studies
    "anki-ppd"
    "notion-snap-reborn"
    "xmind"
    # "kbruch"
    # "buka"
    # "weka"
    # "graphs"
    # "dataexplore"
    # "labplot"

    # Communication
    "discord"

    # Games
    # "ludo"
    # "ppsspp-emu"

    # Others
    "obs-studio"
    "spotify"

    # Finances
    # "vestin"
    # "skrooge"
    # "simplebudget"
    # "mmex"
    # "eqonomize-hk"
    # "retirement-scenarios"
    )

  echo "Installing APT packages..."
  for apt_program in "${apt_programs[@]}"; do
    sudo apt install "$apt_program" -y
  done
  
  snap refresh

  echo "Installing SNAP packages..."
  sudo snap install aws-cli --classic
  sudo snap install code --classic
  #sudo snap install eclipse --classic
  #sudo snap install netbeans --classic
  sudo snap install obsidian --classic
  #sudo snap install sublime-merge --classic
  sudo snap install sublime-text --classic
  
  for snap_program in "${snap_programs[@]}"; do
    sudo snap install "$snap_program"
  done
  
  snap connect nordpass:password-manager-service

  echo "Installing Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i ./google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb

  echo "Installing Jetbrains Toolbox..."
  wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.4.0.32175.tar.gz

  #echo "Configuring Docker to work without sudo permission..."
  #sudo addgroup --system docker
  #sudo adduser $USER docker
  #newgrp docker
  #sudo snap disable docker
  #sudo snap enable docker

  echo "Installing AI..."
  curl -fsSL https://ollama.com/install.sh | sh
  ollama run llama3

  echo "Configuring Git..."
  git config --global credential.helper store
  git config --global user.email eu@raulpacheco.com.br
  git config --global user.name raulpacheco2k

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
