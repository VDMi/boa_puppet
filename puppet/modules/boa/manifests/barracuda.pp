class boa::barracuda {

  class {'boa::barracuda::packages':
  }

  group { "aegir":
    ensure => 'present',
  }

  user {'aegir':
    gid => 'aegir',
    groups => ['www-data'],
    home => '/var/aegir',
    ensure => 'present'
  }
  Class['boa::barracuda::packages'] -> User['aegir']
  Group['aegir'] -> User['aegir']

  file {'/etc/apache2/conf.d/aegir.conf':
    ensure => link,
    target => '/var/aegir/config/apache.conf'
  }
  Class['boa::barracuda::packages'] -> File['/etc/apache2/conf.d/aegir.conf']

  exec {'a2enmod rewrite':
    command => 'a2enmod rewrite',
    path    => ["/usr/bin", "/usr/sbin"]
  }
  Class['boa::barracuda::packages'] -> Exec['a2enmod rewrite']

  # Set memory_limit in /etc/php5/cli/php.ini to 192MB
  # Set memory_limit in /etc/php5/apache2/php.ini to 128MB


  # TODO Put conf in template file.
  $sudocontent = "Defaults:aegir  !requiretty
aegir ALL=NOPASSWD: /usr/sbin/apache2ctl"

  file {'/etc/sudoers.d/aegir':
    content => $sudocontent,
    mode => '440'
  }
  Exec['a2enmod rewrite'] -> File['/etc/sudoers.d/aegir']

  package {'mysql-server':
  }

  # Bind mysql to all addresses.
  $mysql_bindall = "bind-address = 0.0.0.0"
  file {'/etc/mysql/conf.d/bind':
    content => $mysql_bindall,
    notify => Service['mysql']
  }
  Package['mysql-server'] -> File['/etc/mysql/conf.d/bind']

  service { 'mysql':
      ensure   => true,
      enable   => true,
      require  => Package['mysql-server'],
      provider => 'upstart',
    }

}