#!/bin/bash
# Run Fail Safe Command
set -euxo pipefail

###############################
### Wireguard Install & Run ###
###############################

#! From SSH – user (i.e. not root)
sudo ufw allow 46840/udp

mkdir -p ${HOME_DIR}/Docker/Wireguard
cd ${HOME_DIR}/Docker/Wireguard
echo \ 
VULTR_IP=${VULTR_IP} \
WIREGUARD_PORT=${WIREGUARD_PORT} \
> .env
#! docker-compose.yml - user
sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/wireguard/docker-compose.yml > docker-compose.yml
#! build and run container w/ ENV
sudo docker-compose up -d --build
sudo rm -f .env
#? ~ ~ Wait a moment ~ ~ (display's Client QR codes)
#sudo docker exec -it wireguard /app/show-peer 1 3 5