#!/bin/bash

# This script will execute the entire procedure from an external linux machine.
#           Configuration of the VPS (security, firewall, monitoring, noderunner user...)
#           Cloning and execution of the official Elrond Network Node Deployment procedure


## Main function of the script: Called at the end of this file
main() {

# Exit if fail
set -e

# Declare all the configuration variables
source variables.cfg

init

echo -e "\e[32m---------------------------------    Remove the IP from the known hosts in case of precedent installation   ---------------------------------\033[0m"
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$VPS_IP"

# Copy the tarball on the VPS
echo -e "\e[32m---------------------------------    Please enter your VPS user password for copy the tarball on your $VPS_USER user home folder   ---------------------------------\033[0m"
scp elrond-node.tar.bz2 $VPS_USER@$VPS_IP:/home/$VPS_USER/
rm elrond-node.tar.bz2

# Untar it on the VPS
#Run the setup script for Configure the environment (Firewall, permission, Fail4Ban.....), save the output into a log file
echo -e "\e[32m---------------------------------    Please enter your VPS user password   ---------------------------------\033[0m"
ssh -t $VPS_USER@$VPS_IP 'tar -xf /home/ubuntu/elrond-node.tar.bz2 && cd /home/ubuntu/vps-setup/ && sudo ./install_vps.sh 2>&1 | tee /home/ubuntu/vps-setup.log'

# Copy the Elrond Node installation script on the new user
echo -e "\e[32m---------------------------------    Please enter your Noderunner user password   ---------------------------------\033[0m"
ssh -p $MY_SSH_PORT -t $NODERUNNER@$VPS_IP "cp -R /home/$VPS_USER/elrond-node-deploy /home/$NODERUNNER/ && sudo chown -R $NODERUNNER:$NODERUNNER /home/$NODERUNNER/elrond-node-deploy/ && cp -R /home/$VPS_USER/variables.cfg /home/$NODERUNNER/ && cat /home/$NODERUNNER/elrond-node-deploy/bashrc >> /home/$NODERUNNER/.bashrc"

#ssh -p $MY_SSH_PORT -t $NODERUNNER@$VPS_IP "source /home/$NODERUNNER/elrond-node-deploy/install_node.sh"

}

# We configure our current host and prepare the sources to be transfer to the VPS
init() {
    echo -e "\e[32m---------------------------------    Initialization of the environment   ---------------------------------\033[0m"

    echo -e "\e[32m---------------------------------    Verification of the mandatory parameters from variables.cfg   ---------------------------------\033[0m"
    config_error=false

    if ! [[ $VPS_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "\e[31m ERROR: You have no proper IP address for your VPS"
        config_error="true"
    fi

    if [ -z "$VPS_USER" ]; then
        echo -e "\e[31m ERROR: The VPS user field is empty"
        config_error="true"
    fi

    if [ -z "$NODERUNNER" ]; then
        echo -e "\e[31m ERROR: The NODERUNNER user field is empty"
        config_error="true"
    fi

    number_regular_expression='^[0-9]+$'
    if ! [[ $MY_SSH_PORT =~ $number_regular_expression ]] ; then
        echo -e "\e[31m ERROR: The MY_SSH_PORT field is empty"
        config_error="true"
    else
        if [ "$MY_SSH_PORT" -gt "65535" ] || [ "$MY_SSH_PORT" -lt "49152" ]; then
            echo -e "\e[31m ERROR: The MY_SSH_PORT field is incorrect, please select a value between 49152 & 65535"
            config_error="true"
        fi
    fi


    
    if [ -z "$netdatacloud_token" ]; then
        echo -e "\e[33m WARNING: The NetData Configuration is empty -- This configuration step will be ignored"
    fi

    if [ "$HOST_PURPOSE" != "testnet" ] && [ "$HOST_PURPOSE" != "mainnet" ]; then
        echo -e "\e[31m ERROR: The HOST_PURPOSE field is different from \"testnet\" or \"mainnet\" "
        config_error="true"
    fi

    if [ "$config_error" = "true" ]; then
        echo -e "\e[31m --- Please, correct your informations into the variables.cfg "
        exit 1
    fi

    echo -e "\e[32m---------------------------------    Create a tarball of the sources for ssh transfer   ---------------------------------\033[0m"
    tar -cvjf elrond-node.tar.bz2 vps-setup elrond-node-deploy variables.cfg
}

# We call the main function
main;