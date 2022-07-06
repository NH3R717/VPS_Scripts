#!/bin/bash
# Run Fail Safe Command
#set -euxo pipefail


###! Contained is the example version of this project's Linux VPS boot script used to create the Docker hosted NGINX reverse proxy server and Wireguard VPN


##! Add Vultr Start-Up Scripts Through Web Interface


# *********************************************
# Automated Secure Base Ubuntu / Debian Install
# Developer: S Cafe/NH3R717
# *********************************************


#************************
### Add  – Global ENV ###
#************************

echo \
'
##########################################
### Below Added By User During Install ###
##########################################

' >> "/etc/environment"

export USERNAME=example
echo USERNAME=${USERNAME} >> "/etc/environment"

export HOME_DIR="/home/${USERNAME}"
echo HOME_DIR=${HOME_DIR} >> "/etc/environment"

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:${HOME_DIR}/bin
echo PATH=${PATH} >> "/etc/environment"

export WIREGUARD_PORT=46555
echo WIREGUARD_PORT=${WIREGUARD_PORT} >> "/etc/environment"

export VULTR_IP=00.00.000.000
echo VULTR_IP=${VULTR_IP}>> "/etc/environment"

export NETWORK=nginx-proxy
echo NETWORK=${NETWORK}>> "/etc/environment"

export DOMAIN_NAME_1=domain1.com
echo DOMAIN_NAME_1=${DOMAIN_NAME_1} >> "/etc/environment"

export DOMAIN_NAME_2=domain2.com
echo DOMAIN_NAME_2=${DOMAIN_NAME_2} >> "/etc/environment"

export DOMAIN_NAME_3=domain3.com
echo DOMAIN_NAME_3=${DOMAIN_NAME_3} >> "/etc/environment"

export DOMAIN_NAME_4=domain4.com
echo DOMAIN_NAME_4=${DOMAIN_NAME_4} >> "/etc/environment"

export DOMAIN_NAME_5=domain5.com
echo DOMAIN_NAME_5=${DOMAIN_NAME_5} >> "/etc/environment"

export DEFAULT_EMAIL=email@domain1.com
echo DEFAULT_EMAIL=${DEFAULT_EMAIL} >> "/etc/environment"

#********************
### Update – User ###
#********************

# Add sudo user and grant privileges
useradd --create-home --shell "/bin/bash" \
--groups sudo "${USERNAME}"

echo \
'
###########################
### Below Added By User ###
###########################

' \
# Remove sudo password entry requirement
"${USERNAME}" ALL=\(ALL\) NOPASSWD:ALL \
>> /etc/sudoers

# Create SSH directory for sudo user
mkdir "${HOME_DIR}/.ssh"

# Copy public key for the new sudo user
cp /root/.ssh/authorized_keys "${HOME_DIR}/.ssh"

# Adjust sudo user SSH configuration ownership and permissions
chmod 0700 "${HOME_DIR}/.ssh"
chmod 0600 "${HOME_DIR}/.ssh/authorized_keys"
## "USERNAME":"GROUPNAME"
chown --recursive \
"${USERNAME}":"${USERNAME}" "${HOME_DIR}/.ssh"

# Remove root ssh key
echo "no_key" > \
/root/.ssh/authorized_keys

#***********************************************
### Update – SSH Config for Enhanced Security###
#***********************************************

sed --in-place 's/#\?\(PermitRootLogin\s*\).*$/\1no/' \
/etc/ssh/sshd_config

sed --in-place 's/#\?\(PasswordAuthentication\s*\).*$/\1no/' \
/etc/ssh/sshd_config

sed --in-place 's/#\?\(X11Forwarding\s*\).*$/\1no/' \
/etc/ssh/sshd_config

sed --in-place 's/#\?\(Port\s*\).*$/\34555/' \
/etc/ssh/sshd_config

# Restart SSH Daemon
systemctl restart sshd

#*******************************
### Update – FireWall Config ###
#*******************************

#! No IVP6 (may interfere with letsencrypt cert generation)
# sed --in-place 's/#\?\(IPV6\s*\).*$/\1=no/' \
# /etc/default/ufw

# Create new SSH port w/ limit (Default 6 connect attempts within 30 sec)
ufw limit 34555/tcp
# Open standard web ports
ufw allow 80/tcp
ufw allow 443/tcp
# Close standard SSH Port (closes port 22, will use newly created SSH port)
ufw deny 22
# Restart firewall daemon
ufw reload
# Run it for sure and start after a reboot
ufw --force enable

#***************************************************
### Switch to New User w/ Super User Privileges  ###
#***************************************************

su ${USERNAME}
 
#******************************************************
### Docker Containerization Software Install Script ###
#******************************************************

sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/docker/docker_install.sh | exec bash

#***************************************************
### Nginx Reverse Webserver Proxy Install Script ###
#***************************************************

sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/nginx_proxi/nginx_proxy_install.sh | exec bash

#***********************************
### Wireguard VPN Install Script ###
#***********************************

sudo curl -L https://raw.githubusercontent.com/NH3R717/app_wireguard/master/wireguard_install.sh | exec bash

#********************************************
### Supers Install Webpage install Script ###
#********************************************

sudo curl -L https://raw.githubusercontent.com/NH3R717/VPS_Scripts/master/web/web_supers_up.sh | exec bash
