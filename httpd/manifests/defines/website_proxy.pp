define httpd::website_proxy( 		$bind_address = '',
					$proxy_path = '',
					$proxy_website = '',
					$server_name = '',
					$password_protected = '' ) {

	if $password_protected == 'yes' {
                exec { "touch /srv/$name/htpasswd.db":
                        creates => "/srv/$name/htpasswd.db",
			path => [ '/bin', 'usr/bin' ],
                        require => File["/srv/$name"]
                }
        }

	file { "/srv/$name":
		ensure => 'directory',
		owner => 'apache',
		group => 'apache',
		require => Package['httpd']
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
		content => template('httpd/vhost.proxy.conf.erb'),
		notify => Service['httpd'],
		require => [ File["/srv/$name"], File["/srv/$name/log"] ],
	}
		
}
				
