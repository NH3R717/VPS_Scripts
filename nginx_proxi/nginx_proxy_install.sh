#!/bin/bash
exec &>/tmp/nginx_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

###########################
### Nginx Install & Run ###
###########################

export CONTAINER_DIR="${HOME_DIR}/Docker/Nginx"
echo "Created container dir ENV ${CONTAINER_DIR}"

# Create dir for Docker container 
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"

# Import docker-compose.yml
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/nginx_proxi/docker-compose.yml > docker-compose.yml
# Create nginx network
sudo docker network create ${NETWORK}
# Build and run container
docker-compose up -d --build

#  set to user permissions
chmod 0750 "${CONTAINER_DIR}"
chown --recursive \
"${USERNAME}":"${USERNAME}" "${CONTAINER_DIR}"