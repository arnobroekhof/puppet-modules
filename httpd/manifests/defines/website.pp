define httpd::website( 		$bind_address = '',
				$server_name = '',
				$php_enabled = '' ) {

	if $php_enabled == "yes" {
		package { 'php-mysql':
			ensure => 'installed',
			require => Package['httpd']
		}
		package { 'php':
			ensure => 'installed',
			require => Package['httpd']
		}
		package { 'php-xml':
			ensure => 'installed',
			require => Package['httpd']
		}
		package { 'php-cli':
			ensure => 'installed',
			require => Package['httpd']
		}
	}

	file { "/srv/$name":
		ensure => 'directory',
		owner => 'apache',
		group => 'apache',
		require => Package['httpd']
	}

	file { "/srv/$name/www":
		ensure => 'directory',
		owner => 'apache',
		group => 'apache',
		require => File["/srv/$name"],
	}
	file { "/srv/$name/log":
		ensure => 'directory',
		owner => 'apache',
		group => 'apache',
		require => File["/srv/$name"],
	}

	file { "/etc/httpd/conf.d/$name.conf":
		ensure => 'present',
		owner => 'root',
		group => 'root',
		mode => '644',
		content => template('httpd/vhost.conf.erb'),
		notify => Service['httpd'],
		require => [ File["/srv/$name/www"], File["/srv/$name/log"] ],
	}
		
}
				
