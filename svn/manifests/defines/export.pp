define svn::export( $export_path,
		    $svn_url ) {

	file{ "$export_path":
		ensure => 'directory',
	} 
}
