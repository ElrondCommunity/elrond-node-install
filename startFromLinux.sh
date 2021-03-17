#!/bin/bash

# This script will execute the entire procedure from an external linux machine.
#           - Configuration of the VPS (security, firewall, monitoring, noderunner user...)
#           - Cloning and execution of the official Elrond Network Node Deployment procedure


## Main function of the script: Called at the end of this file
main() {

# Exit the script if a function return an error
set -e

# Declare all the configuration variables
source config/variables.cfg

#We call the Check_Config function for check the configuration 
Check_Config

Log-Step "Create a tarball of the sources for ssh transfer"
tar -cvjf elrond-node.tar.bz2 vps-setup node-deploy config

Log-Step "Remove the IP from the known hosts in case of precedent installation"
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$VPS_IP"


Log-Step "Please enter your VPS user password for copy the tarball on your $VPS_USER user home folder with scp"
scp -i ~/.ssh/id_rsa.pub elrond-node.tar.bz2 $VPS_USER@$VPS_IP:/home/$VPS_USER/
rm -rf elrond-node.tar.bz2

Log-Step "Please enter your VPS user password for run the setup script remotely"
Log-Step "It will Configure the environment (Firewall, permission, Fail4Ban.....) by running install_vps.sh"

ssh -t $VPS_USER@$VPS_IP 'tar -xf /home/ubuntu/elrond-node.tar.bz2 && cd /home/ubuntu/vps-setup/ && sudo ./install_vps.sh 2>&1 | tee /home/ubuntu/vps-setup.log'

# Copy the Elrond Node installation script on the new user
Log-Step "Please enter your Noderunner user password for copy all Node related elements into"
ssh -p $MY_SSH_PORT -t $NODERUNNER@$VPS_IP "sudo mv /home/$VPS_USER/node-deploy /home/$VPS_USER/config /home/$NODERUNNER/ && sudo chown -R $NODERUNNER:$NODERUNNER /home/$NODERUNNER/"
}

# We check the configuration in the variables.cfg file
Check_Config() {
    Log-Step "Verification of the configuration from variables.cfg"

    # We store if an error is identified and exit the script at the end in case.
    config_error=false

    if ! [[ $VPS_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        Log-Error "You have no proper IP address for your VPS"
        config_error="true"
    fi

    if [ -z "$VPS_USER" ]; then
        Log-Error "The VPS_User variable is empty"
        config_error="true"
    fi

    if [ -z "$NODERUNNER" ]; then
        Log-Error "The NODERUNNER user variable is empty"
        config_error="true"
    fi

    number_regular_expression='^[0-9]+$'
    if ! [[ $MY_SSH_PORT =~ $number_regular_expression ]] ; then
        Log-Error "The MY_SSH_PORT variable is incorrect"
        config_error="true"
    else
        if [ "$MY_SSH_PORT" -gt "65535" ] || [ "$MY_SSH_PORT" -lt "49152" ]; then
            Log-Error "The MY_SSH_PORT variable is incorrect, please select a value between 49152 & 65535"
            config_error="true"
        fi
    fi
    
    if [ -z "$netdatacloud_token" ]; then
        Log-Warning "The NetData Configuration is empty -- This configuration step will be ignored"
    fi

    if [ "$HOST_PURPOSE" != "testnet" ] && [ "$HOST_PURPOSE" != "mainnet" ]; then
        Log-Error "The HOST_PURPOSE variable is different from \"testnet\" or \"mainnet\" "
        config_error="true"
    fi

    if [ "$config_error" = "true" ]; then
        echo -e "\e[31m ----------------------------------------------------------------"
        echo -e "\e[31m --- Please, Correct your informations into the variables.cfg ---"
        echo -e "\e[31m ----------------------------------------------------------------"
        exit 1
    fi
}



# This function is use to print the different steps of the procedure.
Log-Step() {
    echo -e "\e[32m ###    $1   \033[0m"
}

# This function is use to print the different warnings of the procedure.
Log-Warning() {
    echo -e "\e[33m WARNING:  $1    \033[0m"
}

# This function is use to print the different errors of the procedure.
Log-Error() {
    echo -e "\e[31m ERROR:    $1    \033[0m"
}


# We call the main function after having declared all the functions
main;