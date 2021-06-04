#!/bin/bash
# Run Fail Safe Command
set -euxo pipefail

###########################
### Nginx Install & Run ###
###########################

#! From SSH – user (i.e. not root)
mkdir -p ~/Docker/Nginx /
&& cd ~/Docker/Nginx
#! docker-compose.yml
sudo curl -L https://raw.githubusercontent.com/NH3R717/... > docker-compose.yml
#! build and run container
sudo docker-compose up -d --build