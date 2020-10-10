
#	Elrond Node - Auto Install System

This module provide an automatic way for deploy an Elrond Node on a VPS.

```
elrond-node-install/				- Main folder
├── elrond-node-deploy				- The suit of scripts/solutions, available for the noderunner user.
│   ├── bashrc							- Element to add to the user .bashrc 
│   └── install_node.sh					- Download and configure the elrond-go-scripts-[testnet, mainnet]
└── vps-setup						- Regroup the procedures for the configuration of the VPS
│   ├── functions						- Configuration modules for the different aspects.
│   │   ├── environment.sh					- The environment itself
│   │   ├── netdata.sh						- The NetData monitoring solution (http://netdata.cloud/)
│   │   ├── option.sh						- Check of the required parameters from the variables.cfg
│   │   └── user.sh							- Configuration of the noderunner user
│   ├── install_vps.sh					- Main Script that configure the VPS from the generic VPS User
│   └── resources						- Folder that contains additional ressources
│       └── network-tuning.conf
├── variables.cfg					- MOST IMPORTANT: Configuration of the parameters of the VPS and the Node
├── utils.sh						- Main entry point from an external machine.
└── README.md						- This file
```
## Configuration

The module configuration is centralized into the variables.cfg file.
