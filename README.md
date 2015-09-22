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
$ git clone https://github.com/boundary/boundary-vagrant-casssandra
```

2. Start the virtual machine using your Boundary API Token and Cassandra package name:
```bash
$ BOUNDARY_API_TOKEN=<Boundary API Token> BOUNDARY_CASSANDRA_PACKAGE=<dsc20, dsc21 or dsc22 (default)> vagrant up <virtual machine name>
```
NOTE: Run `vagrant status` to list the name of the virtual machines.

3. Login to the virtual machine
```bash
$ vagrant ssh <virtual machine name>
```
