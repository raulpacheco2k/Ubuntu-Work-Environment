#!/bin/bash

  # Salva logs
  exec > >(tee -i environment_configuration_log.txt)
  exec 2>&1

  # Informações sobre o usuário
  read -p "Informe seu e-mail: " EMAIL
  read -p "Informe seu username: " USERNAME

  # Configurando SSH
  ssh-keygen -t ed25519 -C "$EMAIL"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  chmod 600 ~/.ssh/id_ed25519
  chmod 644 ~/.ssh/id_ed25519.pub

  # Configurando Git
  sudo apt-get install git
  git config --global core.editor "nano"
  git config --global credential.helper store
  git config --global user.email "$EMAIL"
  git config --global user.name "$USERNAME"
  git config --global gpg.format ssh
  git config --global user.signingKey "$(cat ~/.ssh/id_ed25519.pub)"
  git config --global commit.gpgsign true
  git config --global tag.gpgsign true

  # Atualizando o sistema
  sudo add-apt-repository universe -y
  sudo apt-get update -y
  sudo apt-get --fix-broken install
  sudo apt-get upgrade -y

  # Configurando interface Gnome
  gsettings set org.gnome.desktop.interface enable-animations true
  gsettings set org.gnome.nautilus.preferences default-sort-order 'type'

  # Instalando pacotes APT
  sudo apt-get install -y bleachbit
  sudo apt-get install -y curl
  sudo apt-get install -y fastfetch
  sudo apt-get install -y gnome-snapshot
  sudo apt-get install -y net-tools
  sudo apt-get install -y nvtop
  sudo apt-get install -y p7zip-full
  sudo apt-get install -y prelink
  sudo apt-get install -y preload
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y tree
  sudo apt-get install -y ubuntu-drivers-common
  sudo apt-get install -y unison
  sudo apt-get install -y vim
  sudo apt-get install -y wget
  sudo apt-get install -y $(ubuntu-drivers devices | grep recommended | awk '{print $3}')
  sudo apt-get install -y vulkan-tools mesa-utils nvidia-cuda-toolkit

  # Instalando pacotes SNAP
  ## Segurança
  snap install nordpass
  snap connect nordpass:password-manager-service
  ## Estudos e notas
  snap install anki-desktop
  snap install notion-snap-reborn
  snap install obsidian --classic
  snap install xmind
  ## Comunicação
  snap install discord
  ## Utilitários
  snap install btop
  snap install fast
  snap install firefox
  snap install libreoffice
  snap install spotify
  snap install thunderbird
  ## Jogos e lives
  snap install obs-studio
  snap install steam
  ## Desenvolvimento
  snap install aws-cli --classic
  snap install clion --classic
  snap install code --classic
  snap install datagrip --classic
  snap install dataspell --classic
  snap install docker
  snap install eclipse --classic
  snap install goland --classic
  snap install insomnia
  snap install intellij-idea-ultimate --classic
  snap install netbeans --classic
  snap install phpstorm --classic
  snap install postman
  snap install pycharm-professional --classic
  snap install rider --classic
  snap install rubymine --classic
  snap install rustrover --classic
  snap install space
  snap install sublime-merge --classic
  snap install sublime-text --classic
  snap install termius-app   
  snap install webstorm --classic

  # Definindo a placa de vídeo Nvidia como principal
  sudo prime-select nvidia

  # Configurando Docker para funcionar sem permissão sudo
  sudo addgroup --system docker
  sudo adduser $USER docker

  # Instalando Google Chrome.
  #wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  #sudo dpkg -i ./google-chrome-stable_current_amd64.deb
  #rm google-chrome-stable_current_amd64.deb

  # Instalando Electrum
  #sudo apt-get install python3-pyqt6 libsecp256k1-dev python3-cryptography
  #wget https://download.electrum.org/4.6.2/Electrum-4.6.2.tar.gz
  #sudo apt-get install python3-setuptools python3-pip
  #python3 -m pip install --break-system-packages --user Electrum-4.6.2.tar.gz
  #rm Electrum-4.6.2.tar.gz

  # Instalando Ollama
  #curl -fsSL https://ollama.com/install.sh | sh
  #until curl -s http://localhost:11434 > /dev/null; do
  #  sleep 1
  #done
  #ollama pull deepseek-r1:latest

  # Instalando IA Agents
  #curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
  #\. "$HOME/.nvm/nvm.sh"
  #nvm install 24
  #npm install -g @google/gemini-cli
  #npm install -g @anthropic-ai/claude-code

  # Limpeza do sistema 
  sudo apt-get autoremove --purge -y
  sudo apt-get autoclean
  sudo apt-get clean
  sudo journalctl --vacuum-size=1G
  sudo bleachbit --clean system.cache system.trash system.tmp
  sudo fstrim -av
  sudo reboot
