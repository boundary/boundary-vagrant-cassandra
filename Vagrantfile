# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

# Configure additional CPUs and Memory
  config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
  end

  #
  # Add the required puppet modules before provisioning is run by puppet
  #
  config.vm.provision :shell do |shell|
     shell.inline = "puppet module install puppetlabs-stdlib;
                     puppet module install puppetlabs-apt;
                     puppet module install locp-cassandra;
                     puppet module install boundary-boundary;
                     exit 0"
  end

  #
  # Use Puppet to provision the server and setup an elastic search cluster
  # on a single box
  #
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.facter = {
      "boundary_api_token" => ENV["BOUNDARY_API_TOKEN"],
      "cassandra_package" => ENV["BOUNDARY_CASSANDRA_PACKAGE"] ||= "dsc22"
    }
  end

  config.vm.define "centos-6.6", autostart: false do |v|
    v.vm.box = "puppetlabs/centos-6.6-64-puppet"
    v.vm.box_version = "1.0.1"
    v.vm.hostname = "centos-6-6"
  end

  config.vm.define "centos-7.0", autostart: false do |v|
    v.vm.box = "puppetlabs/centos-7.0-64-puppet"
    v.vm.box_version = "1.0.1"
    v.vm.hostname = "centos-7-0"
  end

  config.vm.define "ubuntu-12.04", autostart: false do |v|
    v.vm.box = "puppetlabs/ubuntu-12.04-64-puppet"
    v.vm.box_version = "1.0.1"
    v.vm.hostname = "ubuntu-12-04"
    v.vm.provision "shell", inline: "sed -i 's/127.0.1.1/127.0.0.1/' /etc/hosts"
    
    # Needed to override to change the default outside-in ordering.
    config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "site.pp"
      puppet.facter = {
        "boundary_api_token" => ENV["BOUNDARY_API_TOKEN"],
        "cassandra_package" => ENV["BOUNDARY_CASSANDRA_PACKAGE"] ||= "dsc22"
      }
    end

  end

  config.vm.define "ubuntu-14.04", autostart: false do |v|
    v.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
    # fix box_version until Vagrant support newer versions of puppet.
    v.vm.box_version = "1.0.1"
    v.vm.hostname = "ubuntu-14-04"
    v.vm.provision "shell", inline: "sed -i 's/127.0.1.1/127.0.0.1/' /etc/hosts"
    
    # Needed to override to change the default outside-in ordering.
    config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "site.pp"
      puppet.facter = {
        "boundary_api_token" => ENV["BOUNDARY_API_TOKEN"],
        "cassandra_package" => ENV["BOUNDARY_CASSANDRA_PACKAGE"] ||= "dsc22"
      }
    end
  end

end
