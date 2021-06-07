#!/bin/bash
exec &>/tmp/nginx_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

###########################
### Nginx Install & Run ###
###########################

export CONTAINER_DIR="${HOME_DIR}/Docker/Nginx"

echo ${CONTAINER_DIR}

## Create dir for Docker container – set to user permissions
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"
# Add ENV for docker-compose.yml use
#echo "123=${123}" >> .env
# Import docker-compose.yml
sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/nginx_proxi/docker-compose.yml > docker-compose.yml
# Build and run container
sudo docker-compose up -d --build
#  set to user permissions
chmod 0750 "${CONTAINER_DIR}"
chown --recursive \
"${USERNAME}":"${USERNAME}" "${CONTAINER_DIR}"
# Remove .env
#sudo rm -f .env