
#	Elrond Node - Auto Install System

This module provide an automatic way for deploy an Elrond Node on a VPS.

It will take a freashly installed Ubuntu distribution (18.04 or 20.04), configure the security and prepare it to run Elrond Network nodes.

## Repository Architecture

```

elrond-node-install                 - Main folder of the repository
├── config                          - Folder that contains elements that can/must be modify by the user.
│   ├── bashrc                      - Content that will be add to the end of the NODERUNNER user .bashrc.
│   ├── VALIDATOR_KEYS              - Folder that should contain zip files with the validator keys.
│   │   └── node-0.zip              - Dummy validator key that must be replace with the user one.
│   └── variables.cfg               - Main Variables file: It contains the VPS and the security details.
├── node-deploy                     - Folder that will be copy in the home folder of the NODERUNNER user.
│   └── install_node.sh             - Download and configure the elrond-go-scripts-[testnet, mainnet] : TO RUN AFTER MANUALLY
├── LICENCE                         - MTI Licence file
├── README.md                       - This file
├── startFromLinux.sh               - START the procedure from a remote linux
└── vps-setup                       - Folder that will be copy in the VPS_USER home folder for configure and secure the machine
    ├── functions                   - Regroups scripts that categorize the different phases
    │   ├── environment.sh          - Configuration of the environment (Firewall, third party, dependencies)
    │   ├── netdata.sh              - Script for install netdata automatically
    │   ├── user.sh                 - Create and configure the NODERUNNER user that will host the Elrond node
    │   └── utils.sh                - Additional functions
    ├── install_vps.sh              - Main entry point for configure the VPS
    └── ressources                  - Folder for additional configuration ressources (TO MOVE IN THE CONFIG FOLDER)
        └── network-tuning.conf     - Preconfigure file for network configuration.

```
## Walkthrough

This chapter will explain step by step how to setup your node with the support of this system.

For the moment you must start this procedure from a local Linux for configure a VPS. 

### System Requirements

You will need to have an operating system on which you will run this script.
For the moment we support Linux (tested with Ubuntu 18.04).
Mac OS must be evaluate. 
Windows support will come soon.

We suppose that you already took a VPS provider (OVH, AWS...) that respect the nodes host requirements : https://docs.elrond.com/validators/system-requirements


### Prequisites


At first, you must have a clean linux distribution installed (Ubuntu 18.04 or 20.04) on your VPS. You will then receive the IP and the first user credentials, usually ubuntu.

We consider that you cloned this repository on you local Linux and are ready to start to deploy your node.

### Configuration

The module configuration is centralized around the config folder:

#### variables.cfg

Here you must fill multiple variables that will be use for the entire VPS/Node configuration.

Variable | Mandatory | Details
-------- | -------- | -----
VPS_IP | [x] | Ip V4 address of the VPS machine
VPS_USER | [x] | The username of the user, generated with the distribution installation (usually ubuntu)
NODERUNNER | [x] | The name of the user that will run the node(s)
MY_SSH_PORT | [x] | The port on which the future SSH connection will have to use for access the machine
netdatacloud_token | [] | The token for identify you NetData user.
netdatacloud_warroom_testnet | [] | Token of your room dedicated to monitor testnet nodes
netdatacloud_warroom_mainnet | [] | Token of your room dedicated to monitor mainnet nodes
HOST_PURPOSE | [x] | The purpose of the nodes that will run (testnet or mainnet)
MY_IDENTITY | [x] | The nickname of the node owner



#### VALIDATOR_KEYS

This folder can contains the different validator keys that will be transfer in the home folder of the NODERUNNER user.
We follow the specifications from the official documentation : https://docs.elrond.com/validators/testnet-node/2.-installing-and-updating

If you want to create your own zip from a validatorKey.pem and name them depending on how many nodes you would like to run (node-0, node-1, node-2, ...):

```
zip node-0.zip validatorKey.pem
mv node-0.zip $HOME/VALIDATOR_KEYS/
```

#### Bashrc

This bashrc file will be copy into the .bashrc of the NODERUNNER user. It provides additional function that simplify the maintenance of the nodes.

## Licence

MIT License

Copyright (c) 2020 DarkManipulat (Philippe Martin)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.