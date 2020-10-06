#!/bin/bash

source config.ini

tar -cvjf elrond-node.tar.bz2 elrond-node-setup elrond-node-deploy

#scp (if [ -z VSP_port ] ; then ; else; -P $VSP_port fi;)elrond-node.tar.bz2 $VSP_user@$VSP_ip:/home/ubuntu/


scp elrond-node.tar.bz2 $VSP_user@$VSP_ip:/home/ubuntu/

ssh -t $VSP_user@$VSP_ip 'tar -xf /home/ubuntu/elrond-node.tar.bz2'

ssh -t $VSP_user@$VSP_ip 'cd /home/ubuntu/elrond-node-setup/ && sudo ./setup.sh 2>&1 | tee /home/ubuntu/elrond-node-setup.log'

ssh -p $sshport -t $user@$VSP_ip "cp -R /home/ubuntu/elrond-node-deploy /home/$user/"

ssh -p $sshport -t $user@$VSP_ip "cat /home/$user/elrond-node-deploy/bashrc >> /home/$user/.bashrc"