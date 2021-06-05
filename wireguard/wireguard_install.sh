#!/bin/bash
# Run Fail Safe Command
set -euxo pipefail

###############################
### Wireguard Install & Run ###
###############################

# Open network port – firewall
sudo ufw allow ${WIREGUARD_PORT}/udp
# Dir in user home dir for Docker Compose
mkdir -p ${HOME_DIR}/Docker/Wireguard
cd ${HOME_DIR}/Docker/Wireguard
# Add ENV for docker compose
echo "VULTR_IP=${VULTR_IP}" >> .env
echo "WIREGUARD_PORT=${WIREGUARD_PORT}" >> .env
# Import docker-compose.yml - user
sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/wireguard/docker-compose.yml > docker-compose.yml
# Build and run container w/ ENV
sudo docker-compose up -d --build
# Remove .env
sudo rm -f .env
#? ~ ~ Wait a moment ~ ~ (display's Client QR codes)
#sudo docker exec -it wireguard /app/show-peer 1 3 5