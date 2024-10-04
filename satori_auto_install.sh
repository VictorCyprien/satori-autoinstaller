#!/bin/bash

set -e

echo Updating packages and installing...
sudo apt update
sudo apt install -y mc fail2ban htop vnstat make
echo Done !

echo Enabling fail2ban...
sudo systemctl enable fail2ban.service
sudo systemctl start fail2ban.service
echo Done !

echo Adding Docker...
if ! getent group docker >/dev/null; then
    sudo groupadd docker
fi

if ! groups $USER | grep &>/dev/null "\bdocker\b"; then
    sudo usermod -aG docker $USER
    echo "You need to log out and log back in for the group changes to take effect."
fi

sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
echo Done !

echo Downloading Satori...
cd ~
wget -P ~/ https://satorinet.io/static/download/linux/satori.zip
unzip ~/satori.zip
rm ~/satori.zip
echo Done !

echo Setting localhost to docker container...
cd ~/.satori
sed -i 's/-p 24601:24601 /-p 127.0.0.1:24601:24601 /' satori.py
echo Done !

echo Installing Satori service...
sudo apt install -y python3-venv
bash install.sh
bash install_service.sh
echo Done !

journalctl -u satori.service -f --no-hostname -o cat
