#!/usr/bin/env bash
  
  list_of_apt_programs=(
    git
    ca-certificates
    curl
    gnupg
    lsb-release
    docker-ce 
    docker-ce-cli 
    containerd.io 
    docker-compose-plugin
  )

  list_of_snap_programs=(
    "android-studio --classic"
    "clion --classic"
    "code --classic"
    "datagrip --classic"
    "deckboard"
    "discord"
    "eclipse --classic"
    "insomnia"
    "intellij-idea-ultimate --classic"
    "libreoffice"
    "ludo"
    "netbeans --classic"
    "obs-studio"
    "phpstorm --classic"
    "postman"
    "ppsspp-emu"
    "pycharm-professional --classic"
    "sublime-merge --classic"
    "sublime-text --classic"
    "telegram-desktop"
    "termius-app"
    "webstorm --classic"
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

  echo "Installing APT packages..."
  for apt_program in ${list_of_apt_programs[@]}; do
    echo "[Installing APT package: ] - $apt_program"
    sudo apt install "$apt_program" -y
  done

  echo "Installing Snap packages..."
  sudo apt install snapd -y
  for snap_program in "${list_of_snap_programs[@]}"; do
    echo "[Installing Snap package: ] - $snap_program"
    sudo snap install $snap_program
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
  sudo apt update && sudo apt dist-upgrade -y
  sudo apt autoclean
  sudo apt autoremove -y

  echo "Process finished, press enter..."
  read enter

  read -p "Do you want to restart your computer now? [Y/N]: " option
  if [ "$option" == "y" ] || [ "$option" == "Y" ]; then
    sudo reboot
  fi

  exit 0
