#!/bin/bash
#exec &>/tmp/wagui_boot_script.log
# Run Fail Safe Command
#set -euxo pipefail

echo \
'

#########################
### Web Install & Run ###
#########################

'

################################################
##! Project Dependent ENV / Change as Needed ###

export PROJECT_NAME=web_supers_home
export GIT_BRANCH=dev
export CONTAINER_DIR_NAME=Supers_Home

##! Project Dependent ENV / Change as Needed ###
################################################

export CONTAINER_DIR="${HOME_DIR}/Docker/${CONTAINER_DIR_NAME}"
echo && echo **
echo "Created container dir ${CONTAINER_DIR}"
echo && echo **

# create dir for Docker container & change dir
mkdir -p ${CONTAINER_DIR} && cd "${CONTAINER_DIR}"

echo \
'

####################################

### Install Script Pt.1 Complete ###

######## Running web_up.sh #########

####################################

'

# run web_up script w/ ENV
sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/web_gatsby_up.sh | exec bash

###################################*
### Useful Commands & Notes here ###
###################################*

#! Run from SSH
# sudo curl -L https://raw.githubusercontent.com/NH3R717/web_supers_home/dev/web_supers_home_install.sh | exec bash
#! Run from SSH
# sudo docker stop web_supers_home && sudo docker container prune && sudo docker image prune && sudo rm -rf ~/Docker/Supers_Home
