# Actualizar los repositorios de paquetes
exec { "apt-get update":
    command => "/usr/bin/apt-get update"
}

# Instalación de Apache
package { "apache2":
    ensure => present,
    require => Exec["apt-get update"]
}

# Arrancar el servicio de Apache
service { "apache2":
    ensure => running,
    require => Package["apache2"]
}

# Lista de paquetes de PHP para instalar
$packages = [
    "php5",
    "php5-cli",
    "php5-mysql",
    "php5-dev",
    "php5-curl",
    "php-apc",
    "libapache2-mod-php5"
]

# Instalación de los paquetes de PHP
package { $packages:
    ensure => present,
    require => Exec["apt-get update"],
    notify => Service["apache2"]
}

# Instalación del servidor de MySQL
package { "mysql-server":
    ensure => present,
    require => Exec["apt-get update"]
}

# Arrancar el servicio de MySQL
service { "mysql":
    ensure => running,
    require => Package["mysql-server"]
}
exec { "set-mysql-root-password":
    unless => "mysqladmin -u root -p1234 status",
    command => "mysqladmin -u root password 1234",
    require => Service["mysql"],
    path => "/bin:/usr/bin",
}
# Incluimos el módulo holamundo
include holamundo
