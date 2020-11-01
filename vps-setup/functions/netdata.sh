#!/bin/bash

echo -e "\e[32m---------------------------------  NetData Installation  ---------------------------------\033[0m"
# Net data install with the official kickstarter script
bash <(curl -Ss https://my-netdata.io/kickstart.sh ) --stable-channel --dont-wait


# set netdata variables
case "$HOST_PURPOSE" in
  testnet ) netdatacloud_warroom=$netdatacloud_warroom_testnet 
            elrond_url_api="https://testnet-api.elrond.com/validator/statistics"
	    ;;
  mainnet ) netdatacloud_warroom=$netdatacloud_warroom_mainnet 
            elrond_url_api="https://api.elrond.com/validator/statistics"
	    ;;
esac

sudo netdata-claim.sh -token=$netdatacloud_token -rooms=$netdatacloud_warroom -url=https://app.netdata.cloud
systemctl start netdata