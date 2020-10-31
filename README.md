
#	Elrond Node - Auto Install System

This module provide an automatic way for deploy an Elrond Node on a VPS.

```
elrond-node-install/				- Main folder
├── elrond-node-deploy				- The suit of scripts/solutions, available for the noderunner user.
│   ├── bashrc						- Element to add to the user .bashrc 
│   └── install_node.sh				- Download and configure the elrond-go-scripts-[testnet, mainnet]
└── vps-setup						- Regroup the procedures for the configuration of the VPS
│   ├── functions					- Configuration modules for the different aspects.
│   │   ├── environment.sh			- The environment itself
│   │   ├── netdata.sh				- The NetData monitoring solution (http://netdata.cloud/)
│   │   └── user.sh					- Configuration of the noderunner user
│   ├── install_vps.sh				- Main Script that configure the VPS from the generic VPS User
│   └── resources					- Folder that contains additional ressources
│       └── network-tuning.conf
├── variables.cfg					- MOST IMPORTANT: Configuration of the parameters of the VPS and the Node
├── startFromLinux.sh				- Main entry point from an external linux machine.
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

## Licence

MIT License

Copyright (c) 2020 DarkManipulat

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