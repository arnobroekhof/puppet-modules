define httpd::ssl_website_proxy( 	$ssl_bind_address = '',
				$ssl_certificate = '',
				$ssl_keyfile = '',
				$server_name = '',
				$proxy_website = '',
				$proxy_path = '',
				$password_protected = '') {

	package { "mod_ssl":
		ensure => 'installed'
	}
	package { "openssl":
		ensure => 'installed'
	}
	
	if $password_protected == 'yes' {
                exec { "touch /srv/$name/htpasswd.db":
                        creates => "/srv/$name/htpasswd.db",
			path => [ '/bin', 'usr/bin' ],
                        require => File["/srv/$name"]
                }
        }

	file { "/etc/httpd/conf.d/ssl.conf":
		ensure => 'absent',
		require => Package['mod_ssl']
	}


	file { "/srv/$name":
		ensure => 'directory',
		owner => 'apache',
		group => 'apache',
		require => Package['mod_ssl']
	}

	file { "/srv/$name/log":
		ensure => 'directory',
		owner => 'apache',
		group => 'apache',
		require => File["/srv/$name"],
	}
	file { "/srv/$name/ssl":
		ensure => 'directory',
		owner => 'apache',
		group => 'apache',
		require => File["/srv/$name"],
	}
	if $ssl_certificate == '' {
		# Define ssl certfile and key file
		$ssl_certificate_file = "/srv/$name/ssl/$name.crt"
		$ssl_keyfile_file = "/srv/$name/ssl/$name.key"

		exec { "openssl req -new -newkey rsa:2048 -nodes -out /srv/$name/ssl/$name.csr -keyout /srv/$name/ssl/$name.key -subj '/C=NL/ST=Noord-Holland/L=Amsterdam/O=Online Webhosting/OU=Online Admins/CN=$server_name'":
			alias => "createcsr",
			creates => "/srv/$name/ssl/$name.csr",
			path => [ "/usr/bin", "/usr/sbin", "/bin", "/sbin" ],
			require => [ File["/srv/$name/ssl"],Package['openssl'] ],
		}
		exec {"openssl x509 -req -days 365 -in /srv/$name/ssl/$name.csr -signkey /srv/$name/ssl/$name.key -out /srv/$name/ssl/$name.crt":
			creates => "/srv/$name/ssl/$name.crt",
			alias => "createcrt",
			path => [ "/usr/bin", "/usr/sbin", "/bin", "/sbin" ],
			require => Exec["createcsr"]
		}
		file { "/etc/httpd/conf.d/$name-ssl.conf":
			ensure => 'present',
			owner => 'root',
			group => 'root',
			mode => '644',
			content => template('httpd/ssl.conf.proxy.erb'),
			notify => Service['httpd'],
			require => Exec['createcrt'],
		}
		
	} else {

		$ssl_certificate_file = $ssl_certificate
		$ssl_keyfile_file = $ssl_keyfile

		file { "/etc/httpd/conf.d/$name-ssl.conf":
			ensure => 'present',
			owner => 'root',
			group => 'root',
			mode => '644',
			content => template('httpd/ssl.conf.proxy.erb'),
			require => Package['mod_ssl'],
			notify => Service['httpd']
		}
	}
}
				
