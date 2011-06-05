class httpd(	$bind_addr = '0.0.0.0',
		$bind_port = '80' ) {	
	

	# Make sure the package is installed
	# based on distro
	if $lsbdistid == 'CentOS' {
		package { "httpd":
			ensure => 'installed'
		}
	}
	if $lsbdistid == 'RedHat' {
		package {"httpd":
			ensure => 'installed'
		}
	}
	service { "httpd":
		ensure => 'running',
		require => Package['httpd']
	}

	# template the httpd.conf
	file { "/etc/httpd/conf/httpd.conf":
		ensure => 'present',
		owner => 'root',
		group => 'root',
		mode => '664',
		require => Package['httpd'],
		content => template('httpd/httpd.conf.erb'),
	}
	
	
}
