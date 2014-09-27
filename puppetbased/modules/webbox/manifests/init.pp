class webbox {
	class {"basicdev":}
	
	package {["httpd", "php", "php-devel", "php-pdo", "sqlite", "postgresql-server", "perl", "elinks"]:
		require => Class["basicdev"]
	}

	class {"pip":}
}


