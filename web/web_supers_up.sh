
echo \
'

#################################
### Install Script Pt.1 Start ###
#################################

'

## add ENV for docker-compose.yml use
export DOCKER_WEB=~/Docker/Web
echo "DOCKER_WEB=${DOCKER_WEB}" >> ${DOCKER_WEB}/.env

cd ${DOCKER_WEB}

export NETWORK
echo "NETWORK=${NETWORK}" >> .env

export DOMAIN_NAME_1
echo "DOMAIN_NAME_1=${DOMAIN_NAME_1}" >> .env
export DOMAIN_NAME_5
echo "DOMAIN_NAME_5=${DOMAIN_NAME_5}" >> .env
export DEFAULT_EMAIL
echo "DEFAULT_EMAIL=${DEFAULT_EMAIL}" >> .env

# projects
mkdir Home Instruct Blog Resume

## set RAM memory swap to HD (swap @ <05%)
echo vm.swappiness=05 | sudo tee -a /etc/sysctl.conf
## import web files
# todo docker compose from this repo
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/docker-compose.yml > docker-compose.yml
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/default_page/index.html | tee \
${DOCKER_WEB}Home/index.html \
${DOCKER_WEB}Instruct/index.html \
${DOCKER_WEB}Blog/index.html \
${DOCKER_WEB}Resume/index.html
# curl -L https://raw.githubusercontent.com/NH3R717/web_supers_home/dev/site/index.html
echo \
'

#################################
### Current working directory ###
#################################
'
echo "– ${PWD}"
echo ""
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

## curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/web_supers_up.sh | exec bash

## cd ~/Docker/Web && sudo docker-compose down && sudo docker container prune -y && sudo docker image prune -y && sudo rm -rf ~/Docker/Web