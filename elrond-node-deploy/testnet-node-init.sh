#!/bin/bash

# SET YOUR VARIABLES HERE
me=`whoami`
MY_CUSTOM_HOME="/home/$me"
MY_CUSTOM_USER="$me"
MY_SSHPORT="65203"
MY_GITHUBTOKEN=""
MY_IDENTITY="DarkManipulat"


sudo apt install git
cd $MY_CUSTOM_HOME
git clone https://github.com/ElrondNetwork/elrond-go-scripts-testnet

# MODIFY variable.cfg
sed -i "s|^CUSTOM_HOME=\".*|CUSTOM_HOME=\""$MY_CUSTOM_HOME"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-testnet/config/variables.cfg
sed -i "s|^CUSTOM_USER=\".*|CUSTOM_USER=\""$MY_CUSTOM_USER"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-testnet/config/variables.cfg
sed -i "s|^SSHPORT=\".*|SSHPORT=\""$MY_SSHPORT"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-testnet/config/variables.cfg
sed -i "s|^GITHUBTOKEN=\".*|GITHUBTOKEN=\""$MY_GITHUBTOKEN"\"|" $MY_CUSTOM_HOME/elrond-go-scripts-testnet/config/variables.cfg
sed -i "s|^IDENTITY=\".*|IDENTITY=\""$MY_IDENTITY"\" \#keybaseid|" $MY_CUSTOM_HOME/elrond-go-scripts-testnet/config/variables.cfg

# Go install
cd $MY_CUSTOM_HOME/elrond-go-scripts-testnet
./script.sh install

echo "check $MY_CUSTOM_HOME/elrond-nodes/node-*/config/prefs.toml"

