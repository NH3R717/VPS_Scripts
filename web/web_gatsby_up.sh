
echo \
'

#################################
### Install Script Pt.2 Start ###
#################################

'

# add ENV for docker-compose.yml use

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

## import web files
curl -LO https://github.com/NH3R717/${PROJECT_NAME}/archive/refs/heads/${GIT_BRANCH}.zip
## uncompress webfiles and remove master.zip 
unzip ${GIT_BRANCH}.zip && rm -rf ${GIT_BRANCH}.zip
# import docker-compose.yml
# sudo curl -L https://raw.githubusercontent.com/NH3R717/${PROJECT_NAME}/${GIT_BRANCH}/docker-compose.yml > docker-compose.yml
# build and run container w/ ENV
sudo docker-compose up -d --build



mkdir tmp 
mv docker-compose.yml Dockerfile /public tmp
rm && mv tmp/* .
rm -rf tmp    



# ## add website dir
# mkdir html && cd html
# ## import web files
# curl -LO https://github.com/NH3R717/${PROJECT_NAME}/archive/refs/heads/${GIT_BRANCH}.zip
# ## uncompress webfiles and remove master.zip 
# unzip ${GIT_BRANCH}.zip && rm -rf ${GIT_BRANCH}.zip
# ## remove unnecessary files
# cd "${PROJECT_NAME}-${GIT_BRANCH}" && sudo rm -rf sc && sudo rm -f README.md .gitignore LICENSE gatsby* package* ${PROJECT_NAME}_install.sh
# ## copy files from *-branch to htlm
# cp -a . .. && cd .. && sudo rm -rf "${PROJECT_NAME}-${GIT_BRANCH}" && cd ..
# echo "Current working directory ${PWD}"


# # import docker-compose.yml
# sudo curl -L https://raw.githubusercontent.com/NH3R717/${PROJECT_NAME}/${GIT_BRANCH}/docker-compose.yml > docker-compose.yml
# # build and run container w/ ENV
# sudo docker-compose up -d --build

# set to user permissions
sudo chmod 0750 "${CONTAINER_DIR}"
sudo chown --recursive \
"${USERNAME}":"${USERNAME}" "${CONTAINER_DIR}"

echo \
'

####################################
### Install Script Pt.2 Complete ###
####################################

'