#!/bin/bash
echo -e "\e[32m---------------------------------------------------------------------------------------------\033[0m"
echo -e "\e[32m-                                    USER CREATION                                          -\033[0m"
echo -e "\e[32m---------------------------------------------------------------------------------------------\033[0m"
# add a nonroot user
useradd -s /bin/bash -d /home/$user -m -G sudo $user && echo "user $user added with sudo"
passwd $user