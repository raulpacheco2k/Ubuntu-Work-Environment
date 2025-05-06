#!/bin/bash

  exec > >(tee -i environment_configuration_log.txt)
  exec 2>&1

  echo "Updating repositories..."
  sudo apt update -y

  echo "Customizing Ubuntu..."
  gsettings set org.gnome.desktop.interface enable-animations true
  gsettings set org.gnome.nautilus.preferences default-sort-order 'type'

  echo "Generating SSH keys..."
  ssh-keygen -t ed25519 -C "eu@raulpacheco.com.br"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519

  echo "Configuring Git..."
  git config --global credential.helper store
  git config --global user.email eu@raulpacheco.com.br
  git config --global user.name raulpacheco2k
  git config --global gpg.format ssh
  git config --global user.signingKey "$(cat ~/.ssh/id_ed25519.pub)"
  git config --global commit.gpgsign true
  git config --global tag.gpgsign true

  echo "Installing Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i ./google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb

  apt_programs=(
    curl
    neofetch
    net-tools
    prelink
    preload
    bleachbit
    tree
    unison
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
    "anki-desktop"
    "notion-snap-reborn"
    "xmind"

    # Communication
    "discord"

    # Others
    "obs-studio"
    "spotify"
    "gedit"
  )

  echo "Installing APT packages..."
  for apt_program in "${apt_programs[@]}"; do
    sudo apt install "$apt_program" -y
  done

  echo "Installing SNAP packages..."
  for snap_program in "${snap_programs[@]}"; do
    sudo snap install "$snap_program"
  done

  snap connect nordpass:password-manager-service

  sudo snap install phpstorm --classic
  sudo snap install pycharm-professional --classic
  sudo snap install intellij-idea-ultimate --classic
  sudo snap install webstorm --classic
  sudo snap install clion --classic
  sudo snap install rubymine --classic
  sudo snap install goland --classic
  sudo snap install rustrover --classic
  sudo snap install rider --classic
  sudo snap install datagrip --classic
  sudo snap install dataspell --classic
  sudo snap install space
  sudo snap install code --classic
  sudo snap install eclipse --classic
  sudo snap install netbeans --classic
  sudo snap install aws-cli --classic 
  sudo snap install sublime-merge --classic
  sudo snap install sublime-text --classic
  sudo snap install obsidian --classic

  echo "Installing Electrum..."
  sudo apt-get install python3-pyqt5 libsecp256k1-dev python3-cryptography libzbar0 wget
  wget https://download.electrum.org/4.5.8/Electrum-4.5.8.tar.gz
  sudo apt-get install python3-setuptools python3-pip
  python3 -m pip install --break-system-packages --user Electrum-4.5.8.tar.gz

  echo "Installing AI..."
  curl -fsSL https://ollama.com/install.sh | sh
  ollama run gemma3:1b

  echo "Finalizing, updating and cleaning "
  sudo apt update -y
  sudo apt --fix-broken install
  sudo apt upgrade -y
  sudo apt full-upgrade -y
  sudo apt dist-upgrade -y
  sudo apt autoremove --purge -y
  sudo apt autoclean
  sudo apt clean
  sudo snap refresh
  sudo journalctl --vacuum-size=100M
  sudo bleachbit --clean system.cache system.trash system.tmp
  sudo fstrim -av

  read -p "Setup completed. Do you want to restart your computer now? [Y/N]: " option
  if [ "$option" == "y" ] || [ "$option" == "Y" ]; then
    sudo reboot
  fi

  exit 0
