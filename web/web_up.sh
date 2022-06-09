
echo \
'

#######################
### Install Scriptt ###
#######################

'
export DOCKER_WEB=~/Docker/Web
mkdir ${DOCKER_WEB}
echo "DOCKER_WEB=${DOCKER_WEB}" >> .env

## add ENV for docker-compose.yml use (Supers)
export DOCKER_WEB_SUPERS=~/Docker/Web/Supers
mkdir -pv ${DOCKER_WEB_SUPERS}
echo "DOCKER_WEB_SUPERS=${DOCKER_WEB_SUPERS}" >> .env
## add ENV for docker-compose.yml use (Wagui)
export DOCKER_WEB_WAGUI=~/Docker/Web/Wagui
mkdir -pv ${DOCKER_WEB_WAGUI}
echo "DOCKER_WEB_WAGUI=${DOCKER_WEB_WAGUI}" >> .env


## add ENV for docker-compose.yml use
export NETWORK
echo "NETWORK=${NETWORK}" >> .env

export DOMAIN_NAME_1
echo "DOMAIN_NAME_1=${DOMAIN_NAME_1}" >> .env
export DOMAIN_NAME_4
echo "DOMAIN_NAME_4=${DOMAIN_NAME_4}" >> .env
export DOMAIN_NAME_5
echo "DOMAIN_NAME_5=${DOMAIN_NAME_5}" >> .env
export DEFAULT_EMAIL
echo "DEFAULT_EMAIL=${DEFAULT_EMAIL}" >> .env

# projects
cd ~/Docker/Web && mkdir Supers/Home Supers/Blog Wagui

## set RAM memory swap to HD (swap @ <05%)
echo vm.swappiness=05 | sudo tee -a /etc/sysctl.conf
##! run docker compose (Supers)
cd /Supers
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/supers/docker-compose.yml > docker-compose.yml
## import default web html
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/supers/default_page/index.html | tee \
${DOCKER_WEB_SUPERS}/Home/index.html \
${DOCKER_WEB_SUPERS}/Blog/index.html
sudo docker-compose up -d --build

##! run docker compose (Wagui)
cd ../Wagui
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/wagui/docker-compose.yml > docker-compose.yml
## import default web html
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/wagui/default_page/index.html \
${DOCKER_WEB_WAGUI}/index.html \
sudo docker-compose up -d --build
   
## set to user permissions
sudo chmod 0750 "${DOCKER_WEB}"
sudo chown --recursive \
"${USERNAME}":"${USERNAME}" "${DOCKER_WEB}"

echo \
'

###############################
### Install Script Complete ###
###############################

'

# ! Notes

## curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/web_supers_up.sh | exec bash

## cd ~/Docker/Nginx && sudo docker-compose logs -f

## cd ~/Docker/Web/Supers && sudo docker-compose logs -f

## /Volumes/CLT/web_current/Vultr/Web/web_supers/NavHub/public

## cd ~/Docker/Web/Supers && sudo docker-compose down && sudo docker container prune -f && sudo docker image prune -f && cd ~/Docker && sudo rm -rf ~/Docker/Web