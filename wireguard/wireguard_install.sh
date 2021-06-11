#!/bin/bash
exec &>/tmp/wireguard_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

###############################
### Wireguard Install & Run ###
###############################

export CONTAINER_DIR="${HOME_DIR}/Docker/Wireguard"

echo ${CONTAINER_DIR}

# Open network port for VPN – firewall
sudo ufw allow ${WIREGUARD_PORT}/udp

## Create dir for Docker container
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"

# Add ENV for docker-compose.yml use
echo "VULTR_IP=${VULTR_IP}" >> .env
echo "WIREGUARD_PORT=${WIREGUARD_PORT}" >> .env

# Import docker-compose.yml
sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/wireguard/docker-compose.yml > docker-compose.yml
# Build and run container w/ ENV
sudo docker-compose up -d --build

#  set to user permissions
chmod 0750 "${CONTAINER_DIR}"
chown --recursive \
"${USERNAME}":"${USERNAME}" "${CONTAINER_DIR}"
# Remove .env
# sudo rm -f .env

###################################*
### Useful Commands & Notes here ###
###################################*

#? ~ ~ Wait a moment ~ ~ (display's Client QR codes)
#sudo docker exec -it wireguard /app/show-peer 1 3 5