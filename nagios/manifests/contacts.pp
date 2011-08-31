define nagios_server::contact($namealias, $email) {
		nagios_contact { "$name":
			ensure => 'present',
			contact_name => "$name",
			alias => "$namealias",
			use => 'generic-contact',
			email => $email,
			target => "$nagios_cfgdir/contacts/$name.cfg",
		}

		file { "$nagios_cfgdir/contacts/$name.cfg":
			ensure => 'present',
			owner => 'root',
			group => 'root',
			mode => '755',
			require => nagios_contact["$name"],
		}
}
			
