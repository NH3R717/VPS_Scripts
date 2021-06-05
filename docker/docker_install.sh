#!/bin/bash
# Run Fail Safe Command
set -euxo pipefail

#######################################
### Package Update & Docker Install ###
#######################################

# Update all packages
sudo apt -y update
sudo apt -y upgrade
# Packages specifically required for Docker
sudo apt install -y \
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

# Docker CE install – latest
sudo apt -y update 
sudo apt -y install \
docker-ce \
docker-ce-cli \
containerd.io

## Docker Compose install – 1.29.2
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
 
### Ensure Docker starts at (re)boot
sudo systemctl enable --now docker
sudo systemctl is-enabled docker