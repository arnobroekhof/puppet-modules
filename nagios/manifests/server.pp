class nagios_server{
  file { "$nagios_cfgdir/hosts":
	ensure => 'directory',
	mode => 0755,
        recurse => true,
  }
  file { "$nagios_cfgdir/services":
	ensure => 'directory',
	mode => 0755,
        recurse => true,
  }
  file { "$nagios_cfgdir/contacts":
	ensure => 'directory',
	mode => 0755,
        recurse => true,
  }
  file { "$nagios_cfgdir/templates":
	ensure => 'directory',
	mode => 0755,
        recurse => true,
  }
  file { "$nagios_cfgdir/nagios.cfg":
	ensure => 'present',
	owner => 'root',
	group => 'root',
	mode => '755',
	content => template('nagios/nagios.cfg.erb'),
  }

  file { "$nagios_cfgdir/templates/timeperiods.cfg":
	ensure => 'present',
	owner => 'root',
	group => 'root',
	mode => '755',
	source => "puppet:///nagios/timeperiod-template.cfg",
	require => File["$nagios_cfgdir/templates"],
  }
  file { "$nagios_cfgdir/templates/commands.cfg":
	ensure => 'present',
	owner => 'root',
	group => 'root',
	mode => '755',
	source => "puppet:///nagios/commands-template.cfg",
	require => File["$nagios_cfgdir/templates"],
  }
  file { "$nagios_cfgdir/templates/contacts.cfg":
	ensure => 'present',
	owner => 'root',
	group => 'root',
	mode => '755',
	source => "puppet:///nagios/contact-template.cfg",
	require => File["$nagios_cfgdir/templates"],
  }
  file { "$nagios_cfgdir/templates/hosts.cfg":
	ensure => 'present',
	owner => 'root',
	group => 'root',
	mode => '755',
	source => "puppet:///nagios/host-template.cfg",
	require => File["$nagios_cfgdir/templates"],
  }
  file { "$nagios_cfgdir/templates/services.cfg":
	ensure => 'present',
	owner => 'root',
	group => 'root',
	mode => '755',
	source => "puppet:///nagios/service-template.cfg",
	require => File["$nagios_cfgdir/templates"],
  }
  
  Nagios_host <<||>>
  Nagios_service <<||>>



}
