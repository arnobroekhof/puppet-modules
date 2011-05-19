class svn {

	if $lsbdistid == "CentOS" {
		package{"subversion":
			ensure => "installed",
		}
	}
	if $lsbdistid == "RedHat" {
		package{"subversion":
			ensure => "installed",
		}
	}
	
}
