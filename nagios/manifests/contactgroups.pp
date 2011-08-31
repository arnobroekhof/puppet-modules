define nagios_server::contactgroup {
	nagios_contactgroup { "$name":
		ensure => 'present',
		alias => "$name",
		target => "$nagios_cfgdir/contacts/$name.cfg",
	}

}
