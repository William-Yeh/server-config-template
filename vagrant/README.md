About the Vagrantfile
===

Before starting the Vagrant, you'll need a `Vagrantfile` file in the current working directory.

The `Vagrantfile` can be generated and configured in several ways:

1. configure it automatically via Vagrant Cloud (currently in beta; may charge in the future);

2. search for existing boxes with downloadable URLs;

3. create and edit the `Vagrantfile` by yourself.


## Vagrant Cloud

Steps:

1. Visit [Vagrant Cloud](https://vagrantcloud.com/discover/featured),

2. Pick a box you'd like to start with, and remember its box name, e.g.,

   - `hashicorp/precise64` for Ubuntu 12.04 LTS,
   - `chef/debian-7.4`     for Debian 7.4,
   - `chef/centos-6.5`     for CentOS 6.5,

3. Initialize the box by the box name:

   ```
   $ vagrant  init  hashicorp/precise64
   ```



## Box URL

Steps:

1. Search websites for downloadable vagrant boxes, e.g.,

   - [Vagrantbox.es](http://www.vagrantbox.es/)
   - [Bento](https://github.com/opscode/bento)
   - [Puppet Labs Vagrant Boxes](http://puppet-vagrant-boxes.puppetlabs.com/)

2. Pick the URL of a box you'd like to start with,

3. Name it locally:

   ```
   $ vagrant  box  add  {title}  {url}
   ```

4. Initialize the box:

   ```
   $ vagrant  init  {title}
   ```


## Editing Vagrantfile manually

Edit the two sections of `Vagrantfile` on your own:

1. `config.vm.box`

2. `config.vm.box_url`
