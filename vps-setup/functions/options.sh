#!/bin/bash

echo -e "\e[32m---------------------------------  Check variables.cfg file  ---------------------------------\033[0m"
ip=1.2.3.4

if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "success"
else
  echo "fail"
fi