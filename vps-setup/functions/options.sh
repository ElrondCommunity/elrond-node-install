#!/bin/bash

echo -e "\e[32m---------------------------------  Check variables.cfg file  ---------------------------------\033[0m"


if [[ $VPS_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "VPS_IP OK"
else
  echo "fail"
fi