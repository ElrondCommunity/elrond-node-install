#!/bin/bash

# Exit if fail
set -e

# Declare all the configuration variables
source variables.cfg

ssh-keygen -f "$HOME/.ssh/known_hosts" -R $VPS_IP

#Create a tarball of the sources
tar -cvjf elrond-node.tar.bz2 vps-setup elrond-node-deploy variables.cfg

# Copy the tarball on the VPS
echo -e "\e[32m---------------------------------    Please enter your generic user password   ---------------------------------\033[0m"
scp elrond-node.tar.bz2 $VPS_USER@$VPS_IP:/home/$VPS_USER/
rm elrond-node.tar.bz2

# Untar it on the VPS
echo -e "\e[32m---------------------------------    Please enter your generic user password   ---------------------------------\033[0m"
ssh -t $VPS_USER@$VPS_IP 'tar -xf /home/ubuntu/elrond-node.tar.bz2'

# Run the setup script for Configure the environment (Firewall, permission, Fail4Ban.....), save the output into a log file
# TODO:In the next line, change ubuntu with $VPS_USER
echo -e "\e[32m---------------------------------    Please enter your generic user password   ---------------------------------\033[0m"
ssh -t $VPS_USER@$VPS_IP 'cd /home/ubuntu/vps-setup/ && sudo ./install_vps.sh 2>&1 | tee /home/ubuntu/vps-setup.log'

# Copy the Elrond Node installation script on the new user
echo -e "\e[32m---------------------------------    Please enter your noderunner user password   ---------------------------------\033[0m"
ssh -p $MY_SSH_PORT -t $NODERUNNER@$VPS_IP "cp -R /home/$VPS_USER/elrond-node-deploy /home/$NODERUNNER/"

# TODO: Change the ownership of the folders!!!
ssh -p $MY_SSH_PORT -t $NODERUNNER@$VPS_IP "sudo chown -R $NODERUNNER:$NODERUNNER /home/$NODERUNNER/elrond-node-deploy/ "

# Copy the variables.cfg on the new user home folder
ssh -p $MY_SSH_PORT -t $NODERUNNER@$VPS_IP "cp -R /home/$VPS_USER/variables.cfg /home/$NODERUNNER/"

# Inject the content of the support bashrc into the noderunner user one
ssh -p $MY_SSH_PORT -t $NODERUNNER@$VPS_IP "cat /home/$NODERUNNER/elrond-node-deploy/bashrc >> /home/$NODERUNNER/.bashrc"

#ssh -p $MY_SSH_PORT -t $NODERUNNER@$VPS_IP "source /home/$NODERUNNER/elrond-node-deploy/install_node.sh"
