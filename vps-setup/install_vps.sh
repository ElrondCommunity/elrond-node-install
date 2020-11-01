#!/bin/bash

#-----------------------------------------------------------------------------
#     This script is the entry point for start the configuration of the VPS  |
#-----------------------------------------------------------------------------

# Loading variables file
source ../config/variables.cfg

# Declare some generic functions for the rest of the procedure
source functions/utils.sh

#Update Environment
source functions/environment.sh

source functions/user.sh


#if [ -n $netdatacloud_token ]; then
 #  source functions/netdata.sh
#fi

# At the end of the installation we delete the tarball and the config folder in the VPS_USER for security reasons
rm -rf $HOME/elrond-node.tar.bz2
