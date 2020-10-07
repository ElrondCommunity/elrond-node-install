#!/bin/bash

# Declare all the configuration variables
source config.ini

#Create a tarball of the sources
tar -cvjf elrond-node.tar.bz2 elrond-node-setup elrond-node-deploy config.ini

# Copy the tarball on the VPS
scp elrond-node.tar.bz2 $VPS_NODERUNNER@$VPS_IP:/home/$VPS_NODERUNNER/

# Untar it on the VPS
ssh -t $VPS_NODERUNNER@$VPS_IP 'tar -xf /home/ubuntu/elrond-node.tar.bz2'

# Run the setup script for Configure the environment (Firewall, permission, Fail4Ban.....), save the output into a log file
# TODO:In the next line, change ubuntu with $VPS_NODERUNNER
ssh -t $VPS_NODERUNNER@$VPS_IP 'cd /home/ubuntu/elrond-node-setup/ && sudo ./setup.sh 2>&1 | tee /home/ubuntu/elrond-node-setup.log'

# Copy the Elrond Node installation script on the new NODERUNNER
ssh -p $SSH_PORT -t $NODERUNNER@$VPS_IP "cp -R /home/$VPS_NODERUNNER/elrond-node-deploy /home/$NODERUNNER/"

# Copy the config.ini on the new NODERUNNER home folder
ssh -p $SSH_PORT -t $NODERUNNER@$VPS_IP "cp -R /home/$VPS_NODERUNNER/config.ini /home/$NODERUNNER/"

# Inject the content of the support bashrc into the noderunner NODERUNNER one
ssh -p $SSH_PORT -t $NODERUNNER@$VPS_IP "cat /home/$NODERUNNER/elrond-node-deploy/bashrc >> /home/$NODERUNNER/.bashrc"
