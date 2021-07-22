
echo \
'

#################################
### Install Script Pt.2 Start ###
#################################

'

## add ENV for docker-compose.yml use
echo "CONTAINER_DIR=${CONTAINER_DIR}" >> .env
export NETWORK
echo "NETWORK=${NETWORK}" >> .env

export PROJECT_NAME
echo "PROJECT_NAME=${PROJECT_NAME}" >> .env
export GIT_BRANCH
echo "GIT_BRANCH=${GIT_BRANCH}" >> .env

export DOMAIN_NAME_1
echo "DOMAIN_NAME_1=${DOMAIN_NAME_1}" >> .env
export DOMAIN_NAME_2
echo "DOMAIN_NAME_2=${DOMAIN_NAME_2}" >> .env
export DOMAIN_NAME_3
echo "DOMAIN_NAME_3=${DOMAIN_NAME_3}" >> .env
export DOMAIN_NAME_4
echo "DOMAIN_NAME_4=${DOMAIN_NAME_4}" >> .env
export DOMAIN_NAME_5
echo "DOMAIN_NAME_5=${DOMAIN_NAME_5}" >> .env
export DEFAULT_EMAIL
echo "DEFAULT_EMAIL=${DEFAULT_EMAIL}" >> .env

## set RAM memory swap to HD (@ <05%)
echo vm.swappiness=05 | sudo tee -a /etc/sysctl.conf
## import web files
curl -LO https://github.com/NH3R717/${PROJECT_NAME}/archive/refs/heads/${GIT_BRANCH}.zip
## uncompress webfiles and remove master.zip 
unzip ${GIT_BRANCH}.zip && rm -rf ${GIT_BRANCH}.zip
mv .env "${PROJECT_NAME}-${GIT_BRANCH}"
## build and run container w/ ENV
cd "${PROJECT_NAME}-${GIT_BRANCH}"
echo "Current working directory ${PWD}"
sudo docker-compose up -d --build

## move docker files & remove build files
# mv docker-compose.yml Dockerfile app .env ..
# cd ..
# rm -rf "${PROJECT_NAME}-${GIT_BRANCH}"    

## set to user permissions
sudo chmod 0750 "${CONTAINER_DIR}"
sudo chown --recursive \
"${USERNAME}":"${USERNAME}" "${CONTAINER_DIR}"

echo \
'

####################################
### Install Script Pt.2 Complete ###
####################################

'

#! use with Vultr "plan" : "vc2-4c-8gb", not to be used with strapi data.