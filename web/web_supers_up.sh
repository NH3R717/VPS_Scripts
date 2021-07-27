
echo \
'

#################################
### Install Script Pt.1 Start ###
#################################

'

## add ENV for docker-compose.yml use
export DOCKER_WEB=~/Docker/Web
mkdir ${DOCKER_WEB} && cd ${DOCKER_WEB}
echo "DOCKER_WEB=${DOCKER_WEB}" >> .env


export NETWORK
echo "NETWORK=${NETWORK}" >> .env

export DOMAIN_NAME_1
echo "DOMAIN_NAME_1=${DOMAIN_NAME_1}" >> .env
export DOMAIN_NAME_5
echo "DOMAIN_NAME_5=${DOMAIN_NAME_5}" >> .env
export DEFAULT_EMAIL
echo "DEFAULT_EMAIL=${DEFAULT_EMAIL}" >> .env

# projects
mkdir Home Blog

## set RAM memory swap to HD (swap @ <05%)
echo vm.swappiness=05 | sudo tee -a /etc/sysctl.conf
## import web files
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/docker-compose.yml > docker-compose.yml
curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/default_page/index.html | tee \
~/Docker/Web/Home/index.html \
~/Docker/Web/Blog/index.html \
echo \
'

#################################
### Current Working Directory ###
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

## cd ~/Docker/Nginx && sudo docker-compose logs -f

## cd ~/Docker/Web && sudo docker-compose down && sudo docker container prune -f && sudo docker image prune -f && cd ~/Docker && sudo rm -rf ~/Docker/Web