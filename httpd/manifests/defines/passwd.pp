define httpd::website::passwd( $username, $password ) {
        exec { "htpasswd -sb /srv/$name/htpasswd.db $username $password":
                unless => "grep $username /srv/$name/htpasswd.db",
                path => [ '/bin', '/usr/bin' ],
                require => File["/srv/$name"] 
        }
}
