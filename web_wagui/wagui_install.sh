#!/bin/bash
exec &>/tmp/wagui_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

###############################
### Wireguard Install & Run ###
###############################

export CONTAINER_DIR="${HOME_DIR}/Docker/Wagui"

echo ${CONTAINER_DIR}

## Create dir for Docker container – set to user permissions
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"
## Add website dir
mkdir Web_files && cd Web_files
## Import web files
curl -O https://github.com/NH3R717/Wagui-Restaurant/archive/refs/heads/master.zip
## uncompress webfiles and remove master.zip 
unzip master.zip && rm -f master.zip
# Add ENV for docker-compose.yml use
echo "CONTAINER_DIR=${CONTAINER_DIR}" >> .env
# Import docker-compose.yml
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web_wagui/docker-compose.yml > docker-compose.yml
# Build and run container w/ ENV
docker-compose up -d --build
#  set to user permissions
chmod 0750 "${CONTAINER_DIR}"
chown --recursive \
"${USERNAME}":"${USERNAME}" "${CONTAINER_DIR}"
# Remove .env
rm -f .env

###################################*
### Useful Commands & Notes here ###
###################################*

#? ~ ~ Wait a moment ~ ~ (display's Client QR codes)
#sudo docker exec -it wireguard /app/show-peer 1 3 5