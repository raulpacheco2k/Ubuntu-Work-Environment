#!/bin/bash

  until curl -s http://localhost:11434 > /dev/null; do
   sleep 1
  done
  ollama pull deepseek-r1:latest

  echo "Finalizing, updating and cleaning "
  sudo apt-get update -y
  sudo apt-get --fix-broken install
  sudo apt-get upgrade -y
  sudo apt-get full-upgrade -y
  sudo apt-get dist-upgrade -y
  sudo apt-get autoremove --purge -y
  sudo apt-get autoclean
  sudo apt-get clean
  sudo snap refresh
  sudo journalctl --vacuum-size=100M
  sudo bleachbit --clean system.cache system.trash system.tmp
  sudo fstrim -av

  read -p "Setup completed. Do you want to restart your computer now? [Y/N]: " option
  if [ "$option" == "y" ] || [ "$option" == "Y" ]; then
    sudo reboot
  fi

  exit 0
