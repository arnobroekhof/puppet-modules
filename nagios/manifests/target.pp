class nagios_target {
  @@nagios_host { $fqdn:
        ensure => present,
        alias => $hostname,
        address => $ipaddress,
        use => "linux-server",
        target => "$nagios_cfgdir/hosts/$hostname.cfg",
   }

   @@nagios_service { "check_ping_${hostname}":
        check_command => "check_ping!100.0,20%!500.0,60%",
        use => "generic-service",
        host_name => "$fqdn",
        notification_period => "24x7",
        service_description => "${hostname}_check_ping",
	target => "$nagios_cfgdir/services/$hostname.cfg",
   }
	include nagios_nrpe   
}

class nagios_nrpe {

	package {"nagios-nrpe":
		ensure => 'installed',
	}
	package {"nagios-plugins-nrpe":
		ensure => 'installed',
	}
	service {"nrpe":
		ensure => 'running',
		require => [ Package["nagios-nrpe"], Package['nagios-plugins-nrpe'] ],
	}
	file { "/etc/nagios/nrpe.cfg":
		ensure => 'present',
		owner => 'root',
		group => 'root',
		mode => '755',
		notify => Service['nrpe'],
		require => [ Package['nagios-nrpe'], Package['nagios-plugins-nrpe'] ],
	}
}
