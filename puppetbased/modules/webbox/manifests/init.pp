class webbox {
	class {"basicdev":}
	
	package {["httpd", "php", "php-devel", "php-pdo", "sqlite", "postgresql-server", "perl", "python", "python-devel", "vim-enhanced", "emacs", "elinks"]:
		require => Class["basicdev"]
	}

	class {"pip":}
}


