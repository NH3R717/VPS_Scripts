#!/bin/bash
#exec &>/tmp/docker_web_up.log
# Run Fail Safe Command
set -euxo pipefail

echo \
'

##########################
### Web Install Script ###
##########################

'
## add ENV for docker-compose.yml use (all)
export DOCKER_WEB="${HOME_DIR}/Docker/Web"
mkdir -pv ${DOCKER_WEB} && cd ${DOCKER_WEB}
echo "DOCKER_WEB=${DOCKER_WEB}" >> .env
export NETWORK
echo "NETWORK=${NETWORK}" >> .env

## add ENV for docker-compose.yml use (Supers)
export DOCKER_WEB_SUPERS="${HOME_DIR}/Docker/Web/Supers"
mkdir -pv ${DOCKER_WEB_SUPERS} && cd ${DOCKER_WEB_SUPERS}
echo "DOCKER_WEB_SUPERS=${DOCKER_WEB_SUPERS}" >> .env
export DOMAIN_NAME_1
echo "DOMAIN_NAME_1=${DOMAIN_NAME_1}" >> .env
export DOMAIN_NAME_5
echo "DOMAIN_NAME_5=${DOMAIN_NAME_5}" >> .env
export DEFAULT_EMAIL
echo "DEFAULT_EMAIL=${DEFAULT_EMAIL}" >> .env
export NETWORK
echo "NETWORK=${NETWORK}" >> .env
## add ENV for docker-compose.yml use (Wagui)
export DOCKER_WEB_WAGUI="${HOME_DIR}/Docker/Web/Wagui"
mkdir -pv ${DOCKER_WEB_WAGUI} && cd ${DOCKER_WEB_WAGUI}
echo "DOCKER_WEB_WAGUI=${DOCKER_WEB_WAGUI}" >> .env
export DOMAIN_NAME_4
echo "DOMAIN_NAME_4=${DOMAIN_NAME_4}" >> .env
export DEFAULT_EMAIL
echo "DEFAULT_EMAIL=${DEFAULT_EMAIL}" >> .env
export NETWORK
echo "NETWORK=${NETWORK}" >> .env

## set RAM memory swap to HD (swap @ <05%) – address over memory use w/ low performance tier VPS
echo vm.swappiness=05 | sudo tee -a /etc/sysctl.conf

##! run docker compose (Supers)
cd ../Supers
## download and copy docker-compose file to project directory
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/supers/docker-compose.yml > docker-compose.yml
## import default web html (will load/show this default html prior to uploading actuall project [useful for verifying that server container is up] & build docker server container)
mkdir ${DOCKER_WEB_SUPERS}/Home ${DOCKER_WEB_SUPERS}/Blog
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/supers/default_page/index.html | tee \
${DOCKER_WEB_SUPERS}/Home/index.html \
${DOCKER_WEB_SUPERS}/Blog/index.html
sudo docker-compose up -d --build

##! run docker compose (Wagui)
cd ../Wagui
## download and copy docker-compose file to project directory
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/wagui/docker-compose.yml > docker-compose.yml
## import default web html (will load/show this default html prior to uploading actuall project [useful for verifying that server container is up] & build docker server container)
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/wagui/default_page/index.html | tee \
${DOCKER_WEB_WAGUI}/index.html
sudo docker-compose up -d --build
   
## set to user permissions allowing docker to access files
sudo chmod 0750 "${DOCKER_WEB}"
sudo chown --recursive \
"${USERNAME}":"${USERNAME}" "${DOCKER_WEB}"

echo \
'

###################################
### Web Install Script Complete ###
###################################

'

# ! Notes

## curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/web_supers_up.sh | exec bash

## cd ~/Docker/Nginx && sudo docker-compose logs -f

## cd ~/Docker/Web/Supers && sudo docker-compose logs -f

## /Volumes/CLT/web_current/Vultr/Web/web_supers/NavHub/public

## cd ~/Docker/Web/Supers && sudo docker-compose down && sudo docker container prune -f && sudo docker image prune -f && cd ~/Docker && sudo rm -rf ~/Docker/Web