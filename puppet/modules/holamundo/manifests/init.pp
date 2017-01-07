class holamundo
{

    $vhost_file = "/vagrant/puppet/modules/$name/files/holamundo.conf"
    $index_file = "/vagrant/puppet/modules/$name/files/index.php"

    # Crea el directorio /var/www/holamundo
    file { "/var/www/$name":
        require => Package["apache2"],
        ensure => "directory",
    }

    # Crea el fichero index.php con el contenido de nuestro index.php
    file { "/var/www/$name/index.php":
        require => File["/var/www/$name"],
        ensure => present,
        source => $index_file,
    }

    # Crea el fichero con el host virtual en el directorio sites-available
    file { "/etc/apache2/sites-available/$name.conf":
        require => File["/var/www/$name"],
        ensure => present,
        source => $vhost_file,
    }

    # Crea el enlace del host virtual al directorio sites-enabled
    # y le notificamos al servicio de Apache que se reinicie
    file { "/etc/apache2/sites-enabled/$name.conf":
        require => File["/etc/apache2/sites-available/$name.conf"],
        ensure => link,
        target => "/etc/apache2/sites-available/$name.conf",
        notify => Service['apache2'],
    }

}
