define mysql::createdb( $user, $password ) {
        exec { "create-${name}-db":
                unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
                command => "/usr/bin/mysql -uroot -e \"create database ${name} character set utf8; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
                require => [ Package['mysql-server'], Service["mysqld"], File['/root/.my.cnf'] ]
    }
}
