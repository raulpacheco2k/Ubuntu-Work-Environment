#!/bin/bash
  
  apt_programs=(
    git
    snap
    ca-certificates
    curl
    gnupg
    lsb-release
    docker-ce 
    docker-ce-cli 
    containerd.io 
    docker-compose-plugin
  )

  snap_programs=(
    "deckboard"
    "discord"
    "insomnia"
    "libreoffice"
    "ludo"
    "obs-studio"
    "postman"
    "ppsspp-emu"
    "telegram-desktop"
    "termius-app"
    "weka"
    "spotify"
    "slack"
    "slack-term"
    "notion-snap"
    "mailspring"
    "telegram-cli"
    "thunderbird"
    "nordpass"
    "typora"
    "xmind"
    "anki-ppd"
    "vestin"
    "htop"
    "fast"
    "buka"
    "docker"
  )

  echo "Updating repositories..."
  sudo apt update -y

  # APT
  echo "Installing APT packages..."
  for apt_program in "${apt_programs[@]}"; do
    echo "[Installing APT package: $apt_program]"
    sudo apt install "$apt_program" -y
  done

  # SNAP
  echo "Installing SNAP packages..."
  sudo snap install android-studio --classic
  sudo snap install clion --classic
  sudo snap install code --classic
  sudo snap install datagrip --classic
  sudo snap install eclipse --classic
  sudo snap install intellij-idea-ultimate --classic
  sudo snap install netbeans --classic
  sudo snap install pycharm-professional --classic
  sudo snap install sublime-merge --classic
  sudo snap install sublime-text --classic
  sudo snap install phpstorm --classic
  sudo snap install webstorm --classic
  
  for snap_program in "${snap_programs[@]}"; do
    echo "[Installing SNAP package: $snap_program]"
    sudo snap install "$snap_program"
  done

  echo "Updating repositories..."
  sudo apt update -y

  echo "Installing Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i ./google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb

  echo "Installing Docker and docker-compose..."
  sudo apt-get remove docker docker-engine docker.io containerd runc -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

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
