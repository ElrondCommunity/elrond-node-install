#!/bin/bash

# This script will be launch from the NODERUNNER user for clone and configure the variable.cfg for install the node environment

# We source our own variable.cfg
source ../variables.cfg 

# Set Variables automatically
MY_CUSTOM_HOME="/home/$NODERUNNER"

sudo apt install git
cd $MY_CUSTOM_HOME
git clone https://github.com/ElrondNetwork/elrond-go-scripts-$HOST_PURPOSE

# MODIFY variable.cfg
sed -i "s|^CUSTOM_HOME=\".*|CUSTOM_HOME=\""$MY_CUSTOM_HOME"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^CUSTOM_USER=\".*|CUSTOM_USER=\""$NODERUNNER"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^MY_SSH_PORT=\".*|MY_SSH_PORT=\""$MY_SSH_PORT"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^GITHUBTOKEN=\".*|GITHUBTOKEN=\""$MY_GITHUBTOKEN"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^IDENTITY=\".*|IDENTITY=\""$MY_IDENTITY"\" \#keybaseid|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg

cd $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE
./script.sh install

echo "check $MY_CUSTOM_HOME/elrond-nodes/node-*/config/prefs.toml"

