class boa::barracuda::packages {
  
  exec { "apt-update":
      command => "/usr/bin/apt-get update",
      onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
  }
  Exec["apt-update"] -> Package <| |>

  # For downloading stuff.
  package {'wget':
    ensure => 'latest'
  }

  # For git functionality.
  package {'git-core':
    ensure => 'latest'
  }

  # For acceleration of downloads.
  package {'axel':
    ensure => 'latest'
  }

  # For tcp/ip communication.
  package {'netcat':
    ensure => 'latest'
  }

  # For nginx webserver.
  package {'nginx':
    ensure => 'latest'
  }

  # For super user do.
  package {'sudo':
    ensure => 'latest'
  }

  package {'apache2':
    ensure => 'latest'
  }

  package {'php5':
    ensure => 'latest'
  }

  package {'php5-cli':
    ensure => 'latest'
  }

  package {'php5-gd':
    ensure => 'latest'
  }

  package {'php5-mysql':
    ensure => 'latest'
  }

  package {'php-pear':
    ensure => 'latest'
  }

  package {'postfix':
    ensure => 'latest'
  }

  package {'unzip':
    ensure => 'latest'
  }
  
}