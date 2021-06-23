#!/bin/bash
exec &>/tmp/nginx_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

###########################
### Nginx Install & Run ###
###########################

CONTAINER_DIR="${HOME_DIR}/Docker/Nginx"
echo "Created container dir ENV ${CONTAINER_DIR}"

# create dir for Docker container & change dir
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"

# import docker-compose.yml
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/nginx_proxi/docker-compose.yml > docker-compose.yml
# create nginx network
sudo docker network create ${NETWORK}
# build and run container
docker-compose up -d --build

#  set to user permissions
chmod 0750 "${CONTAINER_DIR}"
chown --recursive \
"${USERNAME}":"${USERNAME}" "${CONTAINER_DIR}"