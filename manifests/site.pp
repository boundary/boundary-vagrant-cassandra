# Explictly set to avoid warning message
Package {
  allow_virtual => false,
}

node /^ubuntu/ {

  file { 'bash_profile':
    path    => '/home/vagrant/.bash_profile',
    ensure  => file,
    source  => '/vagrant/manifests/bash_profile'
  }

  exec { 'update-apt-packages':
    command => '/usr/bin/apt-get update -y',
  }

  class { 'cassandra::datastax_repo':
    before => Class['cassandra']
  }

  class { 'cassandra::java':
   require => Exec['update-apt-packages'],
   before => Class['cassandra']
  }

  class { 'cassandra':
   package_name => $::cassandra_package,
   cluster_name => 'Testing Cluster',
   endpoint_snitch => 'GossipingPropertyFileSnitch',
   listen_address => $::ipaddress_lo,
   num_tokens => 256,
   seeds => "$::ipaddress_lo",
   auto_bootstrap = true,   
   require => Exec['update-apt-packages']
  }

  class { 'boundary':
    token => $::boundary_api_token,
  }

}

# Separate the Cento 7.0 install until the boundary meter puppet package is fixed
node /^centos-7-0/ {
  file { 'bash_profile':
    path    => '/home/vagrant/.bash_profile',
    ensure  => file,
    source  => '/vagrant/manifests/bash_profile'
  }

  exec { 'update-rpm-packages':
    command => '/usr/bin/yum update -y',
    creates => '/vagrant/.locks/update-rpm-packages',
  }

  package {'epel-release':
    ensure => 'installed',
    require => Exec['update-rpm-packages']
  }

}

node /^centos/ {

  file { 'bash_profile':
    path    => '/home/vagrant/.bash_profile',
    ensure  => file,
    require => Class['cassandra'],
    source  => '/vagrant/manifests/bash_profile'
  }

  exec { 'update-rpm-packages':
    command => '/usr/bin/yum update -y',
    creates => '/vagrant/.locks/update-rpm-packages',
  }

  class { 'boundary':
    token => $::boundary_api_token
  }

}
