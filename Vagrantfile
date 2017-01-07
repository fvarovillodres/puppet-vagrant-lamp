Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "public_network", ip: "192.168.1.52"

  # Habilitar aprovisionamiento por Puppet
  config.vm.provision :puppet do |puppet|

    # Localización de los ficheros de configuración manifiestos
    puppet.manifests_path = 'puppet/manifests'

    # Directorio de los módulos
    puppet.module_path = 'puppet/modules'

    # Nombre del manifiesto que se va a ejecutar inicialmente
    puppet.manifest_file = 'default.pp'

    # Opciones de Puppet. Se activa el modo debug y verbose
    puppet.options = [
      '--verbose',
      '--debug',
    ]

  end

end
