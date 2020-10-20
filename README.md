
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
## Walkthrough

This chapter will explain step by step how to setup your node with the support of this system.

### System Requirements

You will need to have an operating system on which you will run this script.
For the moment we support Linux (tested with Ubuntu 18.04) and probably Mac OS. 
Windows support will come soon.

We suppose that you took a VPS provider (OVH, AWS...) that respect the nodes host requirements : https://docs.elrond.com/validators/system-requirements


### Prequisites

At first, you must have a clean linux distribution installed (Ubuntu 18.04) on your VPS. You will then have the IP and the first user credentials, usually ubuntu.

We consider that you cloned this repository on you local Linux and are ready to start to deploy your node.

### Configuration

The module configuration is centralized into the variables.cfg file.

Here you must fill multiple variables that will be use for the entire VPS/Node deployment
