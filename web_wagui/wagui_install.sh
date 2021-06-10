#!/bin/bash
exec &>/tmp/wagui_boot_script.log
# Run Fail Safe Command
set -euxo pipefail

#########################
### Web Install & Run ###
#########################

export CONTAINER_DIR="${HOME_DIR}/Docker/Wagui"

echo ${CONTAINER_DIR}

## Create dir for Docker container – set to user permissions
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"

# Add ENV for docker-compose.yml use
echo "CONTAINER_DIR=${CONTAINER_DIR}" >> .env
# echo "DOMAIN_NAME_1=${DOMAIN_NAME_1}" >> .env
echo "DOMAIN_NAME_2=${DOMAIN_NAME_2}" >> .env
echo "VULTR_IP=${VULTR_IP}" >> .env

## Add website dir
mkdir html && cd html
# Add ENV for docker-compose.yml use
## Import web files
curl -LO https://github.com/NH3R717/Wagui-Restaurant/archive/refs/heads/master.zip
## uncompress webfiles and remove master.zip 
unzip master.zip && rm -rf master.zip
## remove unnecessary files
cd Wagui-Restaurant-master && rm README.md .gitignore
## Copy files from Wagui-Restaurant-master to WebFiles
cp -a . .. && cd .. && rm -rf Wagui-Restaurant-master && cd ..
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
