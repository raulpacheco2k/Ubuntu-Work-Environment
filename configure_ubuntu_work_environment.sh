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
    bleachbit
    tree
    ulauncher
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
    "anki-ppd"
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
  sudo snap install phpstorm --classic
  sudo snap install pycharm-professional --classic
  sudo snap install intellij-idea-ultimate --classic
  sudo snap install webstorm --classic
  sudo snap install clion --classic
  sudo snap install rubymine --classic
  sudo snap install goland --classic
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

  # Snap to test
  # sudo snap install beekeeper-studio
  # sudo snap install node --classic --channel=22

  # Finances
  # "vestin"
  # "skrooge"
  # "simplebudget"
  # "mmex"
  # "eqonomize-hk"
  # "retirement-scenarios"

  # Studies
  # "kbruch"
  # "buka"
  # "weka"
  # "graphs"
  # "dataexplore"
  # "labplot"
  
  # Games
  # "ludo"
  # "ppsspp-emu"

  for snap_program in "${snap_programs[@]}"; do
    sudo snap install "$snap_program"
  done
  
  snap connect nordpass:password-manager-service

  echo "Installing Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i ./google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb

  echo "Installing AI..."
  curl -fsSL https://ollama.com/install.sh | sh
  ollama run gemma3:1b

  echo "Configuring Git..."
  git config --global credential.helper store
  git config --global user.email eu@raulpacheco.com.br
  git config --global user.name raulpacheco2k

  echo "Finalizing, updating and cleaning "
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt dist-upgrade -y
  sudo apt autoremove -y
  sudo apt clean
  sudo apt autoclean
  sudo apt --fix-broken install
  sudo snap refresh
  sudo bleachbit --clean system.cache system.trash system.tmp
  sudo fstrim -av

  echo "Process finished, press enter..."
  read -r enter

  read -p "Do you want to restart your computer now? [Y/N]: " option
  if [ "$option" == "y" ] || [ "$option" == "Y" ]; then
    sudo reboot
  fi

  exit 0
