#!/bin/bash

echo -e "\e[32m---------------------------------  NetData Installation  ---------------------------------\033[0m"
# Net data install with the official kickstarter script
# bash <(curl -Ss https://my-netdata.io/kickstart.sh ) --stable-channel --dont-wait

# Clone and execute script from Distruptive Digital for setup a dashboard adapted to elrond nodes monitoring
git clone https://github.com/disruptivedigital/dd-netdata-install-erdapi.git && cd dd-netdata-install-erdapi && bash netdata-install-config.sh

case "$HOST_PURPOSE" in
  testnet ) netdatacloud_warroom=$netdatacloud_warroom_testnet
	    ;;
  mainnet ) netdatacloud_warroom=$netdatacloud_warroom_mainnet 
	    ;;
esac

sudo netdata-claim.sh -token=$netdatacloud_token -rooms=$netdatacloud_warroom -url=https://app.netdata.cloud