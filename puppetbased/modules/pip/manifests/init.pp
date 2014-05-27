class pip {
	package {"python-setuptools":}

	exec {"easy_install pip":
		path => "/usr/local/bin:/usr/bin:/bin",
		onlyif => "which easy_install",
		unless => "which pip",
		require => Package["python-setuptools"],
	} -> file {"pip-link":
		target => "/usr/bin/pip",
		ensure => "link",
		path => "/usr/bin/pip-python",
	}
}


