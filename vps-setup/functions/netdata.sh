#!/bin/bash

# Net data install
bash <(curl -Ss https://my-netdata.io/kickstart.sh) --stable-channel
# previous install start netdata. Just stop it before modify config
systemctl stop netdata
# set netdata variables
case "$HOST_PURPOSE" in
  testnet ) netdatacloud_warroom=$netdatacloud_warroom_testnet 
            elrond_url_api="https://testnet-api.elrond.com/validator/statistics"
	    ;;
  mainnet ) netdatacloud_warroom=$netdatacloud_warroom_mainnet 
            elrond_url_api="https://api.elrond.com/validator/statistics"
	    ;;
esac
# Extract my netdata config
tar --directory=/etc/netdata/ -xvf my_netdata_config.tar
cp sync.chart.sh /usr/libexec/netdata/charts.d/
chmod +x sync.chart.sh
# MODIFY HOSTNAME_NAME in netdata.conf
sed -i "s|^[ \t]*hostname[ \t]*=.*|\t  hostname = $HOST_PURPOSE $HOSTNAME_NAME|" /etc/netdata/netdata.conf
# MODIFY url monitoring API mainnet vs testnet in sync.charts.sh 
sed -i "s|URL_ELROND_API|$elrond_url_api|" /usr/libexec/netdata/charts.d/sync.chart.sh
# claim nodes to netdata.cloud
netdata-claim.sh -token=$netdatacloud_token -rooms=$netdatacloud_warroom -url=https://app.netdata.cloud
systemctl start netdata