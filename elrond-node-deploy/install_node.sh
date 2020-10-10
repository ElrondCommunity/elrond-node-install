#!/bin/bash

source ../variables.cfg 

# SET YOUR VARIABLES HERE
me=`whoami`
MY_CUSTOM_HOME="/home/$me"
MY_GITHUBTOKEN=""


sudo apt install git
cd $MY_CUSTOM_HOME
git clone https://github.com/ElrondNetwork/elrond-go-scripts-$HOST_PURPOSE

# MODIFY variable.cfg
sed -i "s|^CUSTOM_HOME=\".*|CUSTOM_HOME=\""$MY_CUSTOM_HOME"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^CUSTOM_NODERUNNER=\".*|CUSTOM_NODERUNNER=\""$NODERUNNER"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^MY_SSH_PORT=\".*|MY_SSH_PORT=\""$MY_SSH_PORT"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^GITHUBTOKEN=\".*|GITHUBTOKEN=\""$MY_GITHUBTOKEN"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^IDENTITY=\".*|IDENTITY=\""$MY_IDENTITY"\" \#keybaseid|" $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg

# Go install
cd $MY_CUSTOM_HOME/elrond-go-scripts-$HOST_PURPOSE
./script.sh install

echo "check $MY_CUSTOM_HOME/elrond-nodes/node-*/config/prefs.toml"

