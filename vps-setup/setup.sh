#!/bin/bash

# Loading configuration file
source ../config.ini

#Check options & configuration

source functions/options.sh


#Update Environment
source functions/environment.sh

source functions/user.sh


if [ -n $netdatacloud_token ]; then
 
    source function/netdata.sh
fi
