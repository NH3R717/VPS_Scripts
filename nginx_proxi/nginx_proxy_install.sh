#!/bin/bash
exec &>/tmp/nginx_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

###########################
### Nginx Install & Run ###
###########################

export CONTAINER_DIR="${HOME_DIR}/Docker/Nginx"
export NETWORK=webproxy
echo ${CONTAINER_DIR}


# For docker-gen
# mkdir -p /tmp/templates && cd /tmp/templates
# curl -o nginx.tmpl https://raw.githubusercontent.com/jwilder/docker-gen/master/templates/nginx.tmpl

# Create dir for Docker container – set to user permissions
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"

# Add ENV for docker-compose.yml use
# echo "VULTR_IP=${VULTR_IP}" >> .env
echo NGINX_WEB=nginx-web >> .env
echo DOCKER_GEN=nginx-gen >> .env
echo LETS_ENCRYPT=nginx-letsencrypt >> .env
echo NETWORK=webproxy >> .env
echo NGINX_FILES_PATH=${CONTAINER_DIR} >> .env
echo SERVER_PATH=$(pwd)/.server >> .env
echo ROOT_PATH=$(pwd) >> .env

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
# Remove .env
# rm -f .env

