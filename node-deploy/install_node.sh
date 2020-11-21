#!/bin/bash

# This script will be launch from the NODERUNNER user for improve the environment and install all requirements for run an Elrond node.

# We source our own variable.cfg
source ../config/variables.cfg 
source ../config/bashrc

cat /home/$NODERUNNER/config/bashrc >> /home/$NODERUNNER/.bashrc
rm /home/$NODERUNNER/config/bashrc

mv $HOME/config/VALIDATOR_KEYS $HOME

sudo apt install git
cd
git clone https://github.com/ElrondNetwork/elrond-go-scripts-$HOST_PURPOSE

sed -i "s|^CUSTOM_HOME=\".*|CUSTOM_HOME=\""$HOME"\"|" $HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^CUSTOM_USER=\".*|CUSTOM_USER=\""$NODERUNNER"\"|" $HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^MY_SSH_PORT=\".*|MY_SSH_PORT=\""$MY_SSH_PORT"\"|" $HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^GITHUBTOKEN=\".*|GITHUBTOKEN=\""$MY_GITHUBTOKEN"\"|" $HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg
sed -i "s|^IDENTITY=\".*|IDENTITY=\""$MY_IDENTITY"\" \#keybaseid|" $HOME/elrond-go-scripts-$HOST_PURPOSE/config/variables.cfg

cd $HOME/elrond-go-scripts-$HOST_PURPOSE
./script.sh install

echo "check $HOME/elrond-nodes/node-*/config/prefs.toml"

