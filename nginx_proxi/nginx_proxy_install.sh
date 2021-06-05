#!/bin/bash
# Run Fail Safe Command
set -euxo pipefail

###########################
### Nginx Install & Run ###
###########################

#! From SSH – user (i.e. not root)
mkdir -p ${HOME_DIR}/Docker/Nginx
cd ${HOME_DIR}/Docker/Nginx
#! docker-compose.yml
sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/nginx_proxi/docker-compose.yml > docker-compose.yml
#! build and run container
sudo docker-compose up -d --build