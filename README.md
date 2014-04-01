Simple server configuration template by Ansible and Vagrant
======================

This is a simple template for automated server configuration management.  The main mechanism is:

- [Ansible](http://www.ansibleworks.com/) for configuration management.
- [Vagrant](http://www.vagrantup.com/) for local experiments.


Currently the following software stacks are provided:

- Linux
  - CentOS 6 64bit
  - Debian 7 64bit ("wheezy")

- Java
  - oracle-jdk6
  - oracle-jdk7
  - ant

- DB
  - mariadb
  - cassandra
  - redis

- Web
  - nginx

- Server app development
  - node.js

Other software can be added according to given samples.


# TODO

1. The use of `$`variable is deprecated.

2. Linode load balancer (aka *NodeBalancer*) support.
