#!/bin/bash
exec &>/tmp/docker_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

echo \
'

#######################################
### Package Update & Docker Install ###
#######################################

'
# ENV
export DOCKER_DIR="~/Docker"

# Update all packages
sudo apt-get update -y
sudo apt-get upgrade -y
# Packages required for Docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# GPG key for verifying Docker download
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker Community Edition (CE) install – latest
sudo apt-get update -y
sudo apt-get install -y \
docker-ce docker-ce-cli containerd.io || true

### Ensure Docker starts at boot everytime
sudo systemctl enable --now docker
#? redundent?
sudo systemctl is-enabled docker

## Docker Compose install
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

## Create dir for Docker containers – set to user permissions
mkdir -pv "${DOCKER_DIR}"
chmod 0750 "${DOCKER_DIR}"
chown --recursive \
"${USERNAME}":"${USERNAME}" "${DOCKER_DIR}"

## Install useful dependencies
sudo apt-get install -y zip -y rsync -y htop && sudo apt-get -y autoremove

###################################*
### Useful Commands & Notes here ###
###################################*

#sudo journalctl -eu docker
#sudo systemctl stop docker && sudo sudo dockerd -D
# || true to handle error with specific command