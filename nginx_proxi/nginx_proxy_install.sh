#!/bin/bash
# Run Fail Safe Command
set -euxo pipefail

###########################
### Nginx Install & Run ###
###########################

# Dir in user home dir for Docker Compose
mkdir -p ${HOME_DIR}/Docker/Nginx
cd ${HOME_DIR}/Docker/Nginx
# Import docker-compose.yml - user
sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/nginx_proxi/docker-compose.yml > docker-compose.yml
# Build and run container
sudo docker-compose up -d --build