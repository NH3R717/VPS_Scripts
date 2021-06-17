#!/bin/bash
exec &>/tmp/nginx_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

###########################
### Nginx Install & Run ###
###########################

export CONTAINER_DIR="${HOME_DIR}/Docker/Nginx"
export NETWORK=nginx-proxy
echo ${CONTAINER_DIR}

# Create dir for Docker container – set to user permissions
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"

echo CONTAINER_DIR="${HOME_DIR}/Docker/Nginx" >> .env

# Download the latest version of nginx.tmpl
# mkdir -p /etc/docker-gen/templates/
# curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > /etc/docker-gen/templates/nginx.tmpl

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
# Rem e .env
# rm -f .env