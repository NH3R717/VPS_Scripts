#!/bin/bash
exec &>/tmp/boot_script_wireguard.log
# Run Fail Safe Command
set -euxo pipefail

###############################
### Wireguard Install & Run ###
###############################

export CONTAINER_DIR="${HOME_DIR}/Docker/Wireguard"

# Open network port for VPN – firewall
sudo ufw allow ${WIREGUARD_PORT}/udp
# Add ENV for docker-compose.yml use
echo "VULTR_IP=${VULTR_IP}" >> .env
echo "WIREGUARD_PORT=${WIREGUARD_PORT}" >> .env
# Import docker-compose.yml
sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/wireguard/docker-compose.yml > docker-compose.yml
## Create dir for Docker container – set to user permissions
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"
chmod 0700 "${CONTAINER_DIR}"
chown --recursive \
"${USERNAME}":"${USERNAME}" "${CONTAINER_DIR}"
# Build and run container w/ ENV
sudo docker-compose up -d --build
# Remove .env
sudo rm -f .env

###################################*
### Useful Commands & Notes here ###
###################################*

#? ~ ~ Wait a moment ~ ~ (display's Client QR codes)
#sudo docker exec -it wireguard /app/show-peer 1 3 5