class mysql {

        $mysql_password = "IAmAMySqlPassword"

        package { "mysql-server": ensure => installed }
        package { "mysql": ensure => installed }

        service { "mysqld":
                enable => true,
                ensure => running,
                require => Package["mysql-server"],
        }
        exec { "set-mysql-password":
            unless => "mysqladmin -uroot -p$mysql_password status",
            path => ["/bin", "/usr/bin"],
            command => "mysqladmin -uroot password $mysql_password",
            require => Service["mysqld"],
        }
        file {'/root/.my.cnf':
                owner => 'root', group => 'root',
                content => template('mysql/my.cnf.erb'),
                ensure => 'present',
                require => [ Package['mysql'], Package['mysql-server'], Exec['set-mysql-password'] ]
        }
}
