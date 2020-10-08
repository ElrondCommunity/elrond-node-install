#!/bin/bash
echo -e "\e[32m---------------------------------------------------------------------------------------------\033[0m"
echo -e "\e[32m-                                    NODERUNNER CREATION                                          -\033[0m"
echo -e "\e[32m---------------------------------------------------------------------------------------------\033[0m"
# add a nonroot NODERUNNER
sudo useradd -s /bin/bash -d /home/$NODERUNNER -m -G sudo $NODERUNNER && echo "NODERUNNER $NODERUNNER added with sudo"
passwd $NODERUNNER