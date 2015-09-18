# Boundary Cassandra 

Configures a virtual machine with a Cassandra instance for testing TrueSight Pulse Plugin for Cassandra.

## Prerequistes

- Vagrant 1.72. or later, download [here](https://www.vagrantup.com/downloads.html)
- Virtual Box 4.3.26 or later, download [here](https://www.virtualbox.org/wiki/Downloads)
- git 1.7 or later

## Installation

Prior to installation you need to obtain in your Boundary API Token.

1. Clone the GitHub Repository:
```bash
$ git clone https://github.com/boundary/boundary-vagrant-redis
```

2. Start the virtual machine using your Boundary API Token and Redis version:
```bash
$ BOUNDARY_API_TOKEN=<Boundary API Token> vagrant up <virtual machine name>
```
NOTE: Run `vagrant status` to list the name of the virtual machines.

3. Login to the virtual machine
```bash
$ vagrant ssh <virtual machine name>
```
