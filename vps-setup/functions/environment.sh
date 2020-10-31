#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Segment on ssh port dedicated to the Elrond network nodes
# https://docs.elrond.com/validators/system-requirements
NODE_PORT="37373:38383/tcp"



echo -e "\e[32m------------- Update, Upgrade, Dist-Upgrade Distribution -------------\033[0m"
apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade

echo -e "\e[32m---------------------------------  Change ssh port in sshd_config  ---------------------------------\033[0m"
# Change ssh port in sshd_config
[ -f /etc/ssh/sshd_config.orig ] || cp /etc/ssh/{sshd_config,sshd_config.orig}
cat /etc/ssh/sshd_config |
sed "s/^#*[Pp]ort *[0-9]*$/Port $MY_SSH_PORT/" >/etc/ssh/sshd_config.tmp
mv /etc/ssh/{sshd_config.tmp,sshd_config}
systemctl restart ssh

echo -e "\e[32m---------------------------------    Install Fail2Ban    ---------------------------------\033[0m"
# Installation of Fail4Ban
apt-get -y install fail2ban

# Configuration of the Fail2Ban Jail
echo "[sshd]
enabled = true
port = $MY_SSH_PORT
filter = sshd
logpath = /var/log/auth.log
maxretry = 4" >/etc/fail2ban/jail.local
# Reduce permissions on the jail file
chmod 644 /etc/fail2ban/jail.local

# Start the Fail2Ban daemon and enable it on reboot of the machine
systemctl start fail2ban &&  systemctl enable fail2ban


echo -e "\e[32m---------------------------------    Configure Firewall UFW Rules    ---------------------------------\033[0m"

yes | ufw reset
yes | ufw limit $MY_SSH_PORT
yes | ufw allow $NODE_PORT
yes | ufw enable
yes | ufw status
yes | ufw delete 3
yes | ufw delete 3

echo -e "\e[32m---------------------------------    Tune Network Conf    ---------------------------------\033[0m"
#TODO: Verify the followting functionality.
#cat network-tuning.conf > /etc/sysctl.d/99-network-tuning.conf
#chmod 644 /etc/sysctl.d/99-network-tuning.conf
#sysctl -f /etc/sysctl.d/99-network-tuning.conf



echo -e "\e[32m---------------------------------    Install Additional Tools    ---------------------------------\033[0m"
echo -e "\e[32m------------- python3-pip (pip3) -------------\033[0m"
apt install -y python3-pip
echo -e "\e[32m------------- JSon Query -------------\033[0m"
apt install -y jq
echo -e "\e[32m------------- netstat etc... -------------\033[0m"
apt install -y net-tools
echo -e "\e[32m-------------  iftop -------------\033[0m"
apt install -y iftop


